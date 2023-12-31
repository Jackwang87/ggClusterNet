#' Inter-Domain Ecological Network, we call this biostripe network
#'
#' @param ps phyloseq Object, contains OTU tables, tax table and map table, represented sequences,phylogenetic tree.
#' @param N filter OTU tables by abundance.The defult, N=0.02, extract the top 0.02 relative abundance of OTU.
#' @param r.threshold The defult, r.threshold=0.6, it represents the correlation that the absolute value
#'  of the correlation threshold is greater than 0.6. the value range of correlation threshold from 0 to 1.
#' @param p.threshold The defult, p.threshold=0.05, it represents significance threshold below 0.05.
#' @param  method method for Correlation calculation,method="pearson" is the default value. The alternatives to be passed to cor are "spearman" and "kendall".
#' @examples
#' data(ps)
#' result <- corMicro(ps = ps,N = 0.02,r.threshold=0.6,p.threshold=0.05,method = "pearson")
#' # extract cor matrix
#' cor = result[[1]]
#' @return list which contains OTU correlation matrix
#' @author Contact: Tao Wen \email{taowen@@njau.edu.cn} Penghao Xie \email{2019103106@@njau.edu.cn} yongxin liu \email{yxliu@@genetics.ac.cn} Jun Yuan \email{junyuan@@njau.edu.cn}
#' @references
#'
#' Tao Wen#, Penghao Xie#, Shengdie Yang, Guoqing Niu, Xiaoyu Liu, Zhexu Ding, Chao Xue, Yong-Xin Liu *, Qirong Shen, Jun Yuan*
#' ggClusterNet: an R package for microbiome network analysis and modularity-based multiple network layouts
#' iMeta 2022,DOI: \url{doi: 10.1002/imt2.32}
#' @export




corBiostripe = function(data = NULL, group = NULL,ps = NULL,r.threshold=0.6,p.threshold=0.05,method = "spearman"){

  if (is.null(data)&is.null(group)&!is.null(ps)) {
    otu_table = as.data.frame(t(vegan_otu(ps)))
    tem = otu_table
    #--- use corr.test function to calculate relation#--------
    occor = psych::corr.test(t(otu_table),use="pairwise",method=method,adjust="fdr",alpha=.05)
    occor.r = occor$r
    occor.p = occor$p
    # occor.r[occor.p > p.threshold|abs(occor.r)<r.threshold] = 0
    occor.r[abs(occor.r)<r.threshold] = 0
    occor.r[occor.p > p.threshold] = 0
    tax = as.data.frame((vegan_tax(ps)))
    head(tax)
    A <- levels(as.factor(tax$filed))
    A
    # i = 1
    for (i in 1:length(A)) {
      fil <- intersect(row.names(occor.r),as.character(row.names(tax)[tax$filed == A[i]]))
      a <- row.names(occor.r) %in% fil
      occor.r[a,a] = 0
      occor.p[a,a] = 1
    }

  }


  if (is.null(ps)&!is.null(data)&!is.null(group)) {
    colnames(cordata) = data[[1]]
    cordata <- t(data[-1])
    tem = cordata
    #--- use corr.test function to calculate relation#--------
    occor = psych::corr.test(cordata,use="pairwise",method=method,adjust="fdr",alpha=.05)
    occor.r = occor$r
    occor.p = occor$p
    #-filter--cor value
    occor.r[occor.p > p.threshold|abs(occor.r)<r.threshold] = 0

    #--biostripe network filter
    A <- levels(as.factor(group$Group))



    for (i in 1:length(A)) {
      fil <- intersect(row.names(occor.r),as.character(group[[1]][group$Group == A[i]]))
      a <- row.names(occor.r) %in% fil
      occor.r[a,a] = 0
      occor.p[a,a] = 1
    }

  }


  if (!is.null(ps)&!is.null(data)&!is.null(group)) {
    otu_table = as.data.frame(t(vegan_otu(ps)))
    cordata <- (data[-1])
    row.names(cordata) = data[[1]]

    if (!is.na(match(colnames(otu_table) , data[[1]]))) {
      cordata = t(cordata)
    }
    dim(cordata)
    dim(otu_table)
    finaldata <- rbind(otu_table,cordata)

    tem = t(finaldata) %>% as.data.frame()
    #--- use corr.test function to calculate relation#--------
    occor = psych::corr.test(t(finaldata),use="pairwise",method= method ,adjust="fdr",alpha=.05)
    occor.r = occor$r
    occor.p = occor$p
    occor.r[occor.p > p.threshold|abs(occor.r)<r.threshold] = 0

    tax = as.data.frame((vegan_tax(ps)))
    head(tax)
    if (length(tax$filed) != 0) {
      A1 <- levels(as.factor(tax$filed))
      A1
      A2 <- levels(as.factor(group[[2]]))
      A2
      A = c(A1,A2)

      group2 <- data.frame(SampleID = row.names(tax),Group = tax$filed)
    } else {
      A1 = "OTU"
      A2 <- levels(as.factor(group[[2]]))
      A2
      A = c(A1,A2)
      group2 <- data.frame(SampleID = row.names(tax),Group = "OTU")
    }



    # i = 5
    colnames(group) = c("SampleID","Group")
    finalgru = rbind(group,group2)

    for (i in 1:length(A)) {
      fil <- intersect(row.names(occor.r),as.character(as.character(finalgru$SampleID)[as.character(finalgru$Group) == A[i]]))
      a <- row.names(occor.r) %in% fil
      occor.r[a,a] = 0
      occor.p[a,a] = 1
    }

  }
  return(list(occor.r, method, occor.p, A,tem))

}



