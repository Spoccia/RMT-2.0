#include"mexutils.c"
#include<stdlib.h>
#include<string.h>
#include<math.h>

#undef min
#undef max
#undef abs
#undef greater
#undef sqrtf
#ifndef __cplusplus__
#define sqrtf(x) ((float)sqrt((double)x)
#define greater(a,b) (((double)a) > ((double)b))
#define min(a,b) ((((double)a)<((double)b))?((double)a):((double)b))
#define max(a,b) ((((double)a)>((double)b))?((double)a):((double)b))
#define abs(a) (((double)a>0)?((double)a):((-1.0)*(double)a))
#endif


/*typedef struct
 * {
 * int k1 ;
 * int k2 ;
 * double score ; double accum ;
 * } Pair ;*/


typedef struct
{
    int k1 ;
    int k2 ;
    double matchingScore ; double pruneScore ;
} Pair ;



void
        mexFunction(int nout, mxArray *out[],
        int nin, const mxArray *in[])
{
    int K1, K2, ND, KFeature1, KFeature2, NDFeature1, NDFeature2,KdepdScale1,KdepdScale2,  NDdepdScale1,NDdepdScale2;
    double* L1_pt ;
    double* L2_pt ;
    double* Feature1_pt;
    double* Feature2_pt;
    double* depdScale1_pt;
    double* depdScale2_pt;
    double* amp1_pt;
    double* amp2_pt;
    //double thresh = 1.5 ;
    mxClassID data_class ;
    enum {L1=0,L2, F1, F2, dScale1, dScale2, IndexAmp1, IndexAmp2} ;
    //enum {MATCHES=0,D} ;
    enum {MATCHES=0,D, K} ;
    
    /* ------------------------------------------------------------------
     **                                                Check the arguments
     ** --------------------------------------------------------------- */
    if (nin < 2) {
        mexErrMsgTxt("At least two input arguments required");
    } else if (nout > 3) {
        mexErrMsgTxt("Too many output arguments");
    }
    
    if(!mxIsNumeric(in[L1]) ||
            !mxIsNumeric(in[L2]) ||
            mxGetNumberOfDimensions(in[L1]) > 2 ||
            mxGetNumberOfDimensions(in[L2]) > 2) {
        mexErrMsgTxt("L1 and L2 must be two dimensional numeric arrays") ;
    }
    
    K1 = mxGetN(in[L1]) ;//column
    K2 = mxGetN(in[L2]) ;
    ND = mxGetM(in[L1]) ;//row
    KFeature1 = mxGetN(in[F1]) ;//KFeature1 = K1
    KFeature2 = mxGetN(in[F2]) ;//KFeature2 = K2
    NDFeature1 = mxGetM(in[F1]) ;//NDFeature1 = NDFeature2
    NDFeature2 = mxGetM(in[F2]) ;
    
    depdScale1_pt = (double*)mxGetData(in[dScale1]) ;
    depdScale2_pt = (double*)mxGetData(in[dScale2]) ;
    KdepdScale1 = mxGetN(in[dScale1]) ;//KdepdScale1 = K1
    KdepdScale2 = mxGetN(in[dScale2]) ;//KdepdScale2 = K2
    NDdepdScale1 = mxGetM(in[dScale1]) ;//NDdepdScale1 = NDdepdScale2
    NDdepdScale2 = mxGetM(in[dScale2]) ;

    amp1_pt = (double*)mxGetData(in[IndexAmp1]);
    amp2_pt = (double*)mxGetData(in[IndexAmp2]);
    
    if(mxGetM(in[L2]) != ND) {
        mexErrMsgTxt("L1 and L2 must have the same number of rows") ;
    }
    
    data_class = mxGetClassID(in[L1]) ;
    if(mxGetClassID(in[L2]) != data_class) {
        mexErrMsgTxt("L1 and L2 must be of the same class") ;
    }
    
    L1_pt = (double*)mxGetData(in[L1]) ;
    L2_pt = (double*)mxGetData(in[L2]) ;
    Feature1_pt = (double*)mxGetData(in[F1]) ;
    Feature2_pt = (double*)mxGetData(in[F2]) ;
    
    
    /* ------------------------------------------------------------------
     **                                                         Do the job
     ** --------------------------------------------------------------- */
    {
        
        Pair* pairs_begin = (Pair*) mxMalloc(sizeof(Pair) * (K1+K2)) ;
        /*   Pair* pairs_begin = (Pair*) mxMalloc(sizeof(Pair) * 2 * (K1+K2)) ;*/
        Pair* pairs_iterator = pairs_begin ;
        
        int k1, k2 ;
        int length1 = NDdepdScale1; int length2 = NDdepdScale1;
        double minval = (-1.0)*mxGetInf() ;
        
        for(k1 = 0 ; k1 < K1 ; ++k1, L1_pt += ND, Feature1_pt += NDFeature1, depdScale1_pt += NDdepdScale1,amp1_pt += 1)
        {
            double second_best = minval ;  double best = minval; int second_bestk = -1 ; 
            double bestPruneScore = minval; 
            
            double tcenter1 = Feature1_pt[1];  double depd1 = Feature1_pt[0];
            
            double amp1Value = amp1_pt[0];
            
            double tscope1 = 3*Feature1_pt[3];
            double depdOctave_1 = Feature1_pt[4];
            double timeOctave_1 = Feature1_pt[5];
            
            int bestk = -1 ;
            double accum = 0;
            double ts1 = tcenter1 - tscope1; 
            double te1 = tcenter1+tscope1;
            
            /* For each point P2[k2] in the second image... */
            for(k2 =  0 ; k2 < K2 ; ++k2, L2_pt += ND, Feature2_pt += NDFeature1, depdScale2_pt += NDdepdScale1, amp2_pt += 1)
            {
                double depd2 = Feature2_pt[0];
                double tcenter2 = Feature2_pt[1];   
                double tscope2 = 3*Feature2_pt[3];
                
                double amp2Value = amp2_pt[0];
                double depdOctave_2 = Feature2_pt[4];
                double timeOctave_2 = Feature2_pt[5];
                
                double ts2 = tcenter2-tscope2; 
                double te2=tcenter2+tscope2;
                
                int dbin ;
                double acc = 0 ;
                for(dbin = 0 ; dbin < ND ; ++dbin) {
                    double delta =
                            (L1_pt[dbin]) -
                            (L2_pt[dbin]) ;
                    acc += delta*delta ;
                }
                double shapeDiff = 0;
                if((depdOctave_1 != depdOctave_2) || (timeOctave_1 != timeOctave_2))
                {
                    shapeDiff = 1;
                }
                
                acc = (1 - shapeDiff) /(1+sqrt(acc));
                
                int countInter=0;
                int i=0, j=0;
                while(i<length1&&j<length2)
                {
                    int array1 = (int) depdScale1_pt[i];
                    int array2 = (int) depdScale2_pt[j];
                    if(array1<array2 && array1!=0 && array2 !=0)
                        i++;
                    else if(array1>array2 && array1!=0 && array2 !=0)
                        j++;
                    else if(array1 !=0 && array2 !=0 && array1 == array2)
                    {
                        countInter++;
                        i++;
                        j++;
                    }
                    else
                    {
                        i++;
                        j++;
                    }
                }
                int countUnion=0;
                i=0, j=0;
                length1 = NDdepdScale1; length2 = NDdepdScale1;
                while(i<length1 && j<length2)
                {
                    
                    int array1 = (int) depdScale1_pt[i];
                    int array2 = (int) depdScale2_pt[j];
                    if(array1<array2 && array1 !=0 && array2 !=0)
                    {
                        //mexPrintf("union value: %d \n", array1);
                        i++;
                        countUnion++;
                    }
                    else if(array1>array2 && array1 !=0 && array2 !=0)
                    {
                        // mexPrintf("union value: %d \n", array2);
                        j++;
                        countUnion++;
                    }
                    else if(array1 !=0 && array2 !=0)  // equal
                    {
                        // mexPrintf("union value: %d \n", array1);
                        i++;
                        j++;
                        countUnion++;
                    }
                    else
                    {
                        if(array1 ==0 && array2 !=0)
                        {
                            j++;
                            i++;
                            //  mexPrintf("union value: %d \n", array2);
                            countUnion++;
                        }
                        else if(array2 == 0 && array1 !=0 )
                        {
                            i++;
                            j++;
                            //  mexPrintf("union value: %d \n", array1);
                            countUnion++;
                        }
                        else
                        {
                            if(i<length1) i++;
                            if(j<length2) j++;
                        }
                    }
                }
                
                i=0, j=0;
                int tempDepdSize1 = 0, tempDepdSize2 = 0;
                
                while(i<length1)
                {
                    int array1 = (int) depdScale1_pt[i]; // only name it to array, integer value
                    if(array1 !=0)
                    {
                        tempDepdSize1++;
                    }
                    i++;
                }
                
                while(j < length2)
                {
                    int array2 = (int) depdScale2_pt[j];
                    if(array2 !=0)
                    {
                        tempDepdSize2++;
                    }
                    j++;
                }
                double variateAlignment = countInter/countUnion;
                double tempAmpValue = amp1Value - amp2Value;
                double ampSimlarity = 1/(1+abs(tempAmpValue));
                
                double matchingScore = acc * variateAlignment;
                double pruneScore = acc * variateAlignment;
                
                /* Filter the best and second best matching point. */
                if(matchingScore > best) {
                    second_best = best ; second_bestk = bestk ;
                    best = matchingScore ;
                    bestk = k2 ;
                    bestPruneScore=pruneScore;
                } else if(matchingScore > second_best) {
                    second_best = matchingScore ;
                }
                
            }
            /*jump back to BEGINNING to match the same one*/
            L2_pt -= ND*K2 ;
            Feature2_pt -= NDFeature1*K2;
            depdScale2_pt -= NDdepdScale1*K2;
            amp2_pt -= K2;
            /* Lowe's method: accept the match only if unique. */
            if(bestk != -1) {
                pairs_iterator->k1 = k1 ;
                pairs_iterator->k2 = bestk ;
                pairs_iterator->matchingScore = best ;  
                pairs_iterator->pruneScore = bestPruneScore ;
                pairs_iterator++ ;
            }
            
            
            
        }
        
        /*return pairs_iterator ;  */
        /* ---------------------------------------------------------------
         *                                                        Finalize
         * ------------------------------------------------------------ */
        {
            Pair* pairs_end = pairs_iterator ;
            double* M_pt ;
            double* D_pt = NULL ;
            double* K_pt = NULL ;
            
            out[MATCHES] = mxCreateDoubleMatrix
                    (2, pairs_end-pairs_begin, mxREAL) ;
            
            M_pt = mxGetPr(out[MATCHES]) ;
            
            if(nout > 1) {
                out[D] = mxCreateDoubleMatrix(1,
                        pairs_end-pairs_begin,
                        mxREAL) ;
                D_pt = mxGetPr(out[D]) ;
                
                out[K] = mxCreateDoubleMatrix(2,
                        pairs_end-pairs_begin,
                        mxREAL) ;
                K_pt = mxGetPr(out[K]) ;
                
                
            }
            
            for(pairs_iterator = pairs_begin ;
            pairs_iterator < pairs_end  ;
            ++pairs_iterator) {
                *M_pt++ = pairs_iterator->k1 + 1 ;
                *M_pt++ = pairs_iterator->k2 + 1 ;
                if(nout > 1) {
                    *D_pt++ = pairs_iterator->matchingScore ;
                    *K_pt++ = pairs_iterator->matchingScore ;
                    *K_pt++ = pairs_iterator->pruneScore ;
                }
            }
        }
        mxFree(pairs_begin) ;
    }
}
