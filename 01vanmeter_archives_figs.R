library(ggplot2)
library(plyr)

str(allfrog)
summary(allfrog)
colnames(allfrog)

# indices
#frogs
unique.frogs <- unique(allfrog$Species)  
for(frog in unique.frogs){print(frog)}
index.green <- which(allfrog$Species=="Green treefrog")
print(paste("# green =",length(index.green)))
index.barking <- which(allfrog$Species=="Barking treefrog")
print(paste("# barking =",length(index.barking)))
index.mole <- which(allfrog$Species=="Mole salamander")
print(paste("# mole salamanders =",length(index.mole)))
index.leopard <- which(allfrog$Species=="Leopard frog")
print(paste("# leopard =",length(index.leopard)))
index.fowlers <- which(allfrog$Species=="Fowlers toad")
print(paste("# fowlers =",length(index.fowlers)))
index.gray <- which(allfrog$Species=="Gray treefrog")
print(paste("# gray =",length(index.gray)))
index.cricket <- which(allfrog$Species=="Cricket frog")
print(paste("# cricket =",length(index.cricket)))
index.narrowmouth <- which(allfrog$Species=="Narrowmouth toad")
print(paste("# narrowmouth =",length(index.narrowmouth)))
print(paste("frog records =",length(allfrog$Species)))
count.frogs = length(index.green) + length(index.barking)+ length(index.mole)+ length(index.leopard) +
  length(index.fowlers)+ length(index.gray)+ length(index.cricket)+ length(index.narrowmouth)
print(paste("frog species records =",count.frogs))

#chemicals
unique.chemicals <- unique(allfrog$Chemical)
for(chemical in unique.chemicals){print(chemical)}
index.atrazine <- which(allfrog$Chemical=="Atrazine")
print(paste("# atrazine =",length(index.atrazine)))
index.fipronil <- which(allfrog$Chemical=="Fipronil")
print(paste("# fipronil =",length(index.fipronil)))
index.pendimethalin <- which(allfrog$Chemical=="Pendimethalin")
print(paste("# pendimethalin =",length(index.pendimethalin)))
index.triadimefon <- which(allfrog$Chemical=="Triadimefon")
print(paste("# triadimefon =",length(index.triadimefon)))
index.imidacloprid <- which(allfrog$Chemical=="Imidacloprid")
print(paste("# imidacloprid =",length(index.imidacloprid)))
Nchemicals = length(index.atrazine)+length(index.fipronil)+length(index.pendimethalin)+length(index.triadimefon)+length(index.imidacloprid)
print(paste("# chemicals =",Nchemicals))
#metabolites
index.sulfone <- which(allfrog$Chemical=="Fipronil-Sulfone")
print(paste("# sulfone =",length(index.sulfone)))
index.triadimenol <- which(allfrog$Chemical=="Triadimenol")
print(paste("# triadimenol =",length(index.triadimenol)))
index.deisopropyl <- which(allfrog$Chemical=="Deisopropyl Atrazine")
print(paste("# deisopropyl =",length(index.deisopropyl)))
index.desethyl <- which(allfrog$Chemical=="Desethyl Atrazine")
print(paste("# desethyl =",length(index.desethyl)))
Nmetabolites=length(index.sulfone)+length(index.triadimenol)+length(index.deisopropyl)+length(index.desethyl)
print(paste("# metabolites =",Nmetabolites))
#totals
index.totalatrazine <- which(allfrog$Chemical=="Total Atrazine")
print(paste("# total atrazine =",length(index.totalatrazine)))
index.totaltriadimefon <- which(allfrog$Chemical=="Total Triadimefon")
print(paste("# total triadimefon=",length(index.totaltriadimefon)))
index.totalfipronil <- which(allfrog$Chemical=="Total Fipronil")
print(paste("# total fipronil=",length(index.totalfipronil)))
Ntotals = length(index.totalatrazine)+length(index.totaltriadimefon)+length(index.totalfipronil)
print(paste("# totals =",Ntotals))

Ntotaltotal = Nchemicals + Nmetabolites+Ntotals
print(paste("# total chemical entries =",Ntotaltotal))
print(paste("frog species records =",count.frogs))

#instruments
unique.instruments <- unique(allfrog$Instrument)
for(instrument in unique.instruments){print(instrument)}
index.gcms <- which(allfrog$Instrument=="GCMS")
index.lcms <- which(allfrog$Instrument=="LCMS")
#applications
unique.applications <- unique(allfrog$Application)
for(application in unique.applications){print(application)}
index.soil <- which(allfrog$Application=="Soil")
index.overspray <- which(allfrog$Application=="Overspray")

#construct some factor fields as labels
attach(allfrog)
allfrog$ChemLabel <- paste("Log",allfrog$logKow,allfrog$Chemical,allfrog$Application,allfrog$Instrument)
allfrog$ChemLabel <- as.factor(allfrog$ChemLabel)
unique(paste(Chemical,Application,Instrument))

##############################
#basic histograms and test for normality
allsoil <- allfrog[index.soil,]
dim(allsoil)
#allsoil.lcms <- allsoil[which(allsoil$Instrument=="LCMS"),]
#allsoil.gcms <- allsoil[which(allsoil$Instrument=="GCMS"),]
#View(allsoil)
#View(allsoil.lcms)
#View(allsoil.gcms)
alloverspray <- allfrog[index.overspray,]
dim(alloverspray)
#View(alloverspray)
unique(alloverspray$Species)
index.allsoil.overspray <- which(allfrog$Species==unique(alloverspray$Species))
allsoil.overspray <- allsoil[index.allsoil.overspray,]
dim(allsoil.overspray)
#View(alloverspray)
#alloverspray.lcms <- alloverspray[which(alloverspray$Instrument=="LCMS"),]
#alloverspray.gcms <- alloverspray[which(alloverspray$Instrument=="GCMS"),]
#View(alloverspray)

# ## lump triademefons and fipronils and atrazines (tba)
# ## barkers and greens
# #ignore frogs as a factor for distribution fitting
# ##LCMS
# pdf(paste(frog_out,"hist_app_overspray.pdf",sep=""),width=11,height=8)
# par(mfrow=c(2,2))
# for(chemical in unique.chemicals){
#   chem.soil <- allsoil.overspray$TissueConc[allsoil.overspray$Chemical==chemical]
#   chem.overspray <- alloverspray$TissueConc[alloverspray$Chemical==chemical]
#   this.instrument <- unique(allsoil.overspray$Instrument[allsoil.overspray$Chemical==chemical])
#   #report out sample size
#   print(paste(chemical,this.instrument, "soil samples = ", length(chem.soil)," overspray samples = ", length(chem.overspray)))
#   if(length(chem.soil)>0 && length(chem.overspray)>0){
#     histmin <- min(c(chem.soil,chem.overspray),na.rm=TRUE)
#     histmax <- max(c(chem.soil,chem.overspray),na.rm=TRUE)
#     t.p <- round(t.test(chem.soil,chem.overspray)$p.value,digits=5)
#     hist(chem.soil,main=paste(this.instrument,chemical,"p=",t.p),xlab="Soil Application: Tissue Concentration",col="blue",xlim=c(histmin,histmax))
#     hist(chem.overspray,main=paste(this.instrument,chemical,"p=",t.p),xlab="Overspray Application: Tissue Concentration",col="red",xlim=c(histmin,histmax))
#   }
# }
# dev.off()

#lcms boxplots for barkers and greens that compare soil versus overspray
# for imidacloprid, total atrazine, total triadimefon, total fipronil, and pendimethalin
index.goodchems = c(index.imidacloprid,index.totalatrazine,index.totaltriadimefon,index.totalfipronil,index.pendimethalin)
spray.boxplot <- allfrog[index.goodchems,]
spray.boxplot <- spray.boxplot[spray.boxplot$Instrument=="LCMS",]
#View(spray.boxplot[spray.boxplot$Species=="Barking treefrog"|spray.boxplot$Species=="Green treefrog",])
spray.boxplot <- spray.boxplot[spray.boxplot$Species=="Barking treefrog"|spray.boxplot$Species=="Green treefrog",]
dim(spray.boxplot)
#View(spray.boxplot)
colnames(spray.boxplot)
spray.boxplot[which(spray.boxplot$Chemical=="Total Atrazine"),3] = "Atrazine"
spray.boxplot[which(spray.boxplot$Chemical=="Total Triadimefon"),3] = "Triadimefon"
spray.boxplot[which(spray.boxplot$Chemical=="Total Fipronil"),3] = "Fipronil"

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

dim(spray.boxplot)
#View(spray.boxplot)
spray.boxplot[11:15,11] <- NA


pdf(paste(frog_out,"fig2_boxplot_soil_spray_bcf.pdf",sep=""),width=8.5,height=11)
spray.barkingtreefrog <- na.omit(spray.boxplot[spray.boxplot=="Barking treefrog",])
spray.factors <- reorder(spray.barkingtreefrog$Chemical, spray.barkingtreefrog$logKow)
p1 <- qplot(spray.factors, BCF, fill=factor(Application), data=spray.barkingtreefrog,
            geom="boxplot",xlab="",ylab="Barking treefrog BCF")+annotate("text", x=5, y=3.3, label="A")+
  #annotate("text", x=1, y=-0.25, label="***")+annotate("text", x=2, y=-0.25, label="*")+
  #annotate("text", x=3, y=-0.25, label="**")+annotate("text", x=4, y=-0.25, label="***")+
  #annotate("text", x=5, y=-0.25, label="***")+
  theme_bw() +scale_fill_grey(start=0.5, end=1) + labs(fill="Application")
spray.greentreefrog <- na.omit(spray.boxplot[spray.boxplot=="Green treefrog",])
p2 <- qplot(reorder(Chemical,logKow), BCF, fill=factor(Application), data=spray.greentreefrog, 
            geom="boxplot",xlab="Pesticide",ylab="Green treefrog BCF")+annotate("text", x=4, y=1.2, label="B")+
  #annotate("text", x=1, y=-0.25, label="***")+annotate("text", x=2, y=-0.25, label="**")+
  #annotate("text", x=3, y=-0.25, label="**")+annotate("text", x=4, y=-0.25, label="***")+
  theme_bw()+scale_fill_grey(start=0.5, end=1) + labs(fill="Application")
multiplot(p1, p2)
dev.off()

pdf(paste(frog_out,"fig1_boxplot_soil_spray_tissueconc.pdf",sep=""),width=8.5,height=11)
spray.barkingtreefrog <- na.omit(spray.boxplot[spray.boxplot=="Barking treefrog",])
spray.factors <- reorder(spray.barkingtreefrog$Chemical, spray.barkingtreefrog$logKow)
p1 <- qplot(spray.factors, TissueConc, fill=factor(Application), data=spray.barkingtreefrog,
            geom="boxplot",xlab="",ylab="Barking treefrog Tissue Concentration (ppm)")+annotate("text", x=5, y=17, label="A")+
  #annotate("text", x=1, y=-1.25, label="***")+annotate("text", x=2, y=-1.25, label="*")+
  #annotate("text", x=3, y=-1.25, label="**")+annotate("text", x=4, y=-1.25, label="***")+
  #annotate("text", x=5, y=-1.25, label="***")+
  theme_bw() +scale_fill_grey(start=0.5, end=1) + labs(fill="Application")
spray.greentreefrog <- na.omit(spray.boxplot[spray.boxplot=="Green treefrog",])
p2 <- qplot(reorder(Chemical,logKow), TissueConc, fill=factor(Application), data=spray.greentreefrog, 
            geom="boxplot",xlab="Pesticide",ylab="Green treefrog Tissue Concentration (ppm)")+annotate("text", x=4, y=21, label="B")+
  #annotate("text", x=1, y=-1.25, label="***")+annotate("text", x=2, y=-1.25, label="**")+
  #annotate("text", x=3, y=-1.25, label="**")+annotate("text", x=4, y=-1.25, label="***")+
  theme_bw()+scale_fill_grey(start=0.5, end=1) + labs(fill="Application")
multiplot(p1, p2)
dev.off()



# pdf(paste(frog_out,"barchart_soil_spray.pdf",sep=""),width=8.5,height=11)
# #create a data frame with averages and standard deviations
# bt <- spray.boxplot[spray.boxplot=="Barking treefrog",]
# bcf.avg<-ddply(bt, c("Chemical", "Application"), function(df)
#   return(c(bcf.avg=mean(df$BCF), bcf.sd=sd(df$BCF),bcf.logKow=mean(df$logKow))))
# #create the barplot component
# dodge <- position_dodge(width=0.9)
# avg.plot<-qplot(reorder(Chemical,bcf.logKow), bcf.avg, fill=factor(Application), 
#                 data=bcf.avg, xlab="",ylab="Barking treefrog BCF",geom="bar", position="dodge")
# #add error bars
# p1 <- avg.plot+geom_errorbar(aes(ymax=bcf.avg+bcf.sd, ymin=bcf.avg-bcf.sd),position="dodge")+
#   annotate("text", x=5, y=3.3, label="A")+theme_bw()+ labs(fill="Application")
# 
# gt <- spray.boxplot[spray.boxplot=="Green treefrog",]
# bcf.avg<-ddply(gt, c("Chemical", "Application"), function(df)
#   return(c(bcf.avg=mean(df$BCF), bcf.sd=sd(df$BCF),bcf.logKow=mean(df$logKow))))
# bcf.avg[5,3]=NA
# bcf.avg[5,4]=NA
# #create the barplot component
# dodge <- position_dodge(width=0.9)
# avg.plot<-qplot(reorder(Chemical,bcf.logKow), bcf.avg, fill=factor(Application), 
#                 data=bcf.avg, xlab="Pesticide",ylab="Green treefrog BCF",geom="bar", position="dodge")
# #add error bars
# p2 <- avg.plot+geom_errorbar(aes(ymax=bcf.avg+bcf.sd, ymin=bcf.avg-bcf.sd), position="dodge")+
#   annotate("text", x=5, y=1.2, label="B")+theme_bw()+ labs(fill="Application")
# multiplot(p1, p2)
# dev.off()
