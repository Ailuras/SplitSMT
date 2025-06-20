(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2993 0)
(declare-sort var1 0)
(declare-sort var107 0)
(declare-sort var946 0)
(declare-sort var1123 0)
(declare-sort var3535 0)
(declare-sort var1758 0)
(declare-sort var2784 0)
(declare-sort var1760 0)
(declare-sort var3147 0)
(declare-sort var708 0)
(declare-sort var1199 0)
(declare-sort var2442 0)
(declare-sort var1079 0)
(declare-sort var3925 0)
(declare-sort var1657 0)
(declare-sort var1338 0)
(declare-sort var3979 0)
(declare-sort var685 0)
(declare-sort var529 0)
(declare-sort var1290 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var107) void)
(declare-fun cast-from-var2993-to-var107 (var2993) var107)
(declare-fun getClass/1258963082 (var107) ClassObject)
(declare-fun var1123_getErrorTypeAwareLogger/453021605 (ClassObject) var946)
(declare-fun logger/-1923175899 (var2993) var946)
(declare-fun var3535-init () var3535)
(declare-fun <init>/964458484 (var3535) void)
(declare-fun properties/-1923175899 (var2993) var3535)
(declare-fun var1758-init () var1758)
(declare-fun <init>/-1889012253 (var1758 String Bool) void)
(declare-fun var1760_newFixedThreadPool/-923551937 (Int var3147) var2784)
(declare-fun cast-from-var1758-to-var3147 (var1758) var3147)
(declare-fun reportCacheExecutor/-1923175899 (var2993) var2784)
(declare-fun var708-init () var708)
(declare-fun <init>/-334308776 (var708 Int) void)
(declare-fun cast-from-var708-to-var1199 (var708) var1199)
(declare-fun allMetadataReports/-1923175899 (var2993) var1199)
(declare-fun var2442-init () var2442)
(declare-fun <init>/1827284532 (var2442) void)
(declare-fun lastCacheChanged/-1923175899 (var2993) var2442)
(declare-fun failedReports/-1923175899 (var2993) var1199)
(declare-fun var1079-init () var1079)
(declare-fun <init>/-1201058856 (var1079 Bool) void)
(declare-fun initialized/-1923175899 (var2993) var1079)
(declare-fun setUrl/-479382679 (var2993 var1) void)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var1) var3925)
(declare-fun applicationModel/-1923175899 (var2993) var3925)
(declare-fun getParameter/2144001655 (var1 String Bool) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1657_getSystemProperty/1393069448 (String) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getApplication/-536601276 (var1) String)
(declare-fun getAddress/-2093578336 (var1) String)
(declare-fun var1338_replace/553341465 (String String String) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getParameter/506106603 (var1 String String) String)
(declare-fun file/-1923175899 (var2993) var3979)
(declare-fun loadProperties/-1005210489 (var2993) void)
(declare-fun syncReport/-1923175899 (var2993) Bool)
(declare-fun var685-init () var685)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun getParameter/448702405 (var1 String Int) Int)
(declare-fun <init>/-540273274 (var685 var2993 Int Int) void)
(declare-fun metadataReportRetry/-1923175899 (var2993) var685)
(declare-fun booleanValue/-1820462562 (var1290) Bool)
(declare-fun reportMetadata/-1923175899 (var2993) Bool)
(declare-fun reportDefinition/-1923175899 (var2993) Bool)
(declare-const null-var2993 var2993)
(declare-const null-var1 var1)
(declare-const null-var3979 var3979)
(declare-const var529-DEFAULT_METADATA_REPORT_RETRY_TIMES Int)
(declare-const var529-DEFAULT_METADATA_REPORT_RETRY_PERIOD Int)
(declare-const var529-DEFAULT_METADATA_REPORT_CYCLE_REPORT var1290)
(declare-const var1492 var2993) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport 
(assert (not (= var1492 null-var2993)))
(declare-const var2066 var1) ; Statement: r10 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2066 null-var1)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2993-to-var107 var1492))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1492!1 var2993)
(assert true)
(define-const var3244 ClassObject (getClass/1258963082 (cast-from-var2993-to-var107 var1492!1))) ; Statement: $r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var802 var946 (var1123_getErrorTypeAwareLogger/453021605 var3244)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>($r1) 
(declare-const var1492!2 var2993)
(assert (not (= var1492!2 null-var2993)))
(assert (= (logger/-1923175899 var1492!2) var802)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r2 
(define-const var3930 var3535 var3535-init) ; Statement: $r3 = new java.util.Properties 
(assert true)
;(assert (<init>/964458484 var3930)) ; Statement: specialinvoke $r3.<java.util.Properties: void <init>()>() 

(declare-const var3930!1 var3535)
(declare-const var1492!3 var2993)
(assert (not (= var1492!3 null-var2993)))
(assert (= (properties/-1923175899 var1492!3) var3930!1)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Properties properties> = $r3 
(define-const var3031 var1758 var1758-init) ; Statement: $r4 = new org.apache.dubbo.common.utils.NamedThreadFactory 
(assert true)
;(assert (<init>/-1889012253 var3031 "DubboSaveMetadataReport" (ite (= 1 1) true false))) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.utils.NamedThreadFactory: void <init>(java.lang.String,boolean)>("DubboSaveMetadataReport", 1) 

(declare-const var3031!1 var1758)
(declare-const var1732 String)
(declare-const var3574 Int)
(define-const var2137 var2784 (var1760_newFixedThreadPool/-923551937 1 (cast-from-var1758-to-var3147 var3031!1))) ; Statement: $r5 = staticinvoke <java.util.concurrent.Executors: java.util.concurrent.ExecutorService newFixedThreadPool(int,java.util.concurrent.ThreadFactory)>(1, $r4) 
(declare-const var1492!4 var2993)
(assert (not (= var1492!4 null-var2993)))
(assert (= (reportCacheExecutor/-1923175899 var1492!4) var2137)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.ExecutorService reportCacheExecutor> = $r5 
(define-const var3898 var708 var708-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-334308776 var3898 4)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>(int)>(4) 

(declare-const var3898!1 var708)
(declare-const var1663 Int)
(declare-const var1492!5 var2993)
(assert (not (= var1492!5 null-var2993)))
(assert (= (allMetadataReports/-1923175899 var1492!5) (cast-from-var708-to-var1199 var3898!1))) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map allMetadataReports> = $r6 
(define-const var3211 var2442 var2442-init) ; Statement: $r7 = new java.util.concurrent.atomic.AtomicLong 
(assert true)
;(assert (<init>/1827284532 var3211)) ; Statement: specialinvoke $r7.<java.util.concurrent.atomic.AtomicLong: void <init>()>() 

(declare-const var3211!1 var2442)
(declare-const var1492!6 var2993)
(assert (not (= var1492!6 null-var2993)))
(assert (= (lastCacheChanged/-1923175899 var1492!6) var3211!1)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.atomic.AtomicLong lastCacheChanged> = $r7 
(define-const var3687 var708 var708-init) ; Statement: $r8 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-334308776 var3687 4)) ; Statement: specialinvoke $r8.<java.util.concurrent.ConcurrentHashMap: void <init>(int)>(4) 

(declare-const var3687!1 var708)
(declare-const var1663!1 Int)
(declare-const var1492!7 var2993)
(assert (not (= var1492!7 null-var2993)))
(assert (= (failedReports/-1923175899 var1492!7) (cast-from-var708-to-var1199 var3687!1))) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports> = $r8 
(define-const var630 var1079 var1079-init) ; Statement: $r9 = new java.util.concurrent.atomic.AtomicBoolean 
(assert true)
;(assert (<init>/-1201058856 var630 (ite (= 1 0) true false))) ; Statement: specialinvoke $r9.<java.util.concurrent.atomic.AtomicBoolean: void <init>(boolean)>(0) 

(declare-const var630!1 var1079)
(declare-const var1091 Int)
(declare-const var1492!8 var2993)
(assert (not (= var1492!8 null-var2993)))
(assert (= (initialized/-1923175899 var1492!8) var630!1)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.atomic.AtomicBoolean initialized> = $r9 
(assert true)
;(assert (setUrl/-479382679 var1492!8 var2066)) ; Statement: virtualinvoke r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: void setUrl(org.apache.dubbo.common.URL)>(r10) 

(declare-const var1492!9 var2993)
(declare-const var2066!1 var1)
(assert true)
(define-const var3207 var3925 (getOrDefaultApplicationModel/-1374397043 var2066!1)) ; Statement: $r11 = virtualinvoke r10.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(declare-const var1492!10 var2993)
(assert (not (= var1492!10 null-var2993)))
(assert (= (applicationModel/-1923175899 var1492!10) var3207)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = $r11 
(assert true)
(define-const var3996 Bool (getParameter/2144001655 var2066!1 "file-cache" (ite (= 1 1) true false))) ; Statement: z0 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("file-cache", 1) 
(define-const var3013 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3013)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3013!1 String)
(assert (= var3013!1 ""))
(define-const var3423 String (var1657_getSystemProperty/1393069448 "user.home")) ; Statement: $r13 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("user.home") 
(assert true)
(define-const var3637 String (append/672562846 var3013!1 var3423)) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var3013!2 String)
(assert (= var3013!2 (str.++ var3013!1 var3423)))
(assert true)
(define-const var2184 String (append/672562846 var3637 "/.dubbo/dubbo-metadata-")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/.dubbo/dubbo-metadata-") 
(declare-const var3637!1 String)
(assert (= var3637!1 (str.++ var3637 "/.dubbo/dubbo-metadata-")))
(assert true)
(define-const var2525 String (getApplication/-536601276 var2066!1)) ; Statement: $r15 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(assert true)
(define-const var2547 String (append/672562846 var2184 var2525)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var2184!1 String)
(assert (= var2184!1 (str.++ var2184 var2525)))
(assert true)
(define-const var3322 String (append/672562846 var2547 "-")) ; Statement: $r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-") 
(declare-const var2547!1 String)
(assert (= var2547!1 (str.++ var2547 "-")))
(assert true)
(define-const var3395 String (getAddress/-2093578336 var2066!1)) ; Statement: $r18 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(define-const var3064 String (var1338_replace/553341465 var3395 ":" "-")) ; Statement: $r19 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>($r18, ":", "-") 
(assert true)
(define-const var2303 String (append/672562846 var3322 var3064)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var3322!1 String)
(assert (= var3322!1 (str.++ var3322 var3064)))
(assert true)
(define-const var2623 String (append/672562846 var2303 ".cache")) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".cache") 
(declare-const var2303!1 String)
(assert (= var2303!1 (str.++ var2303 ".cache")))
(assert true)
(define-const var2180 String (toString/-2075883882 var2623)) ; Statement: r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var3263 String (getParameter/506106603 var2066!1 "file" var2180)) ; Statement: r24 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("file", r23) 
(define-const var3917 var3979 null-var3979) ; Statement: r43 = null 
 ; Statement: if z0 == 0 goto r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.io.File file> = r43 
(assert (= (ite var3996 1 0) 0)) ; Cond: z0 == 0 
(declare-const var1492!11 var2993)
(assert (not (= var1492!11 null-var2993)))
(assert (= (file/-1923175899 var1492!11) var3917)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.io.File file> = r43 
(assert true)
;(assert (loadProperties/-1005210489 var1492!11)) ; Statement: virtualinvoke r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: void loadProperties()>() 

(declare-const var1492!12 var2993)
(assert true)
(define-const var1289 Bool (getParameter/2144001655 var2066!1 "sync-report" (ite (= 1 0) true false))) ; Statement: $z9 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("sync-report", 0) 
(declare-const var1492!13 var2993)
(assert (not (= var1492!13 null-var2993)))
(assert (= (syncReport/-1923175899 var1492!13) var1289)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean syncReport> = $z9 
(define-const var2010 var685 var685-init) ; Statement: $r45 = new org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry 
(define-const var2562 Int var529-DEFAULT_METADATA_REPORT_RETRY_TIMES) ; Statement: $r46 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Integer DEFAULT_METADATA_REPORT_RETRY_TIMES> 
(assert true)
(define-const var855 Int (intValue/-1815674922 var2562)) ; Statement: $i1 = virtualinvoke $r46.<java.lang.Integer: int intValue()>() 
(assert true)
(define-const var263 Int (getParameter/448702405 var2066!1 "retry-times" var855)) ; Statement: $i2 = virtualinvoke r10.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("retry-times", $i1) 
(define-const var1078 Int var529-DEFAULT_METADATA_REPORT_RETRY_PERIOD) ; Statement: $r47 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Integer DEFAULT_METADATA_REPORT_RETRY_PERIOD> 
(assert true)
(define-const var1516 Int (intValue/-1815674922 var1078)) ; Statement: $i3 = virtualinvoke $r47.<java.lang.Integer: int intValue()>() 
(assert true)
(define-const var1660 Int (getParameter/448702405 var2066!1 "retry-period" var1516)) ; Statement: $i4 = virtualinvoke r10.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("retry-period", $i3) 
(assert true)
;(assert (<init>/-540273274 var2010 var1492!13 var263 var1660)) ; Statement: specialinvoke $r45.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void <init>(org.apache.dubbo.metadata.report.support.AbstractMetadataReport,int,int)>(r0, $i2, $i4) 

(declare-const var2010!1 var685)
(declare-const var1492!14 var2993)
(declare-const var263!1 Int)
(declare-const var1660!1 Int)
(declare-const var1492!15 var2993)
(assert (not (= var1492!15 null-var2993)))
(assert (= (metadataReportRetry/-1923175899 var1492!15) var2010!1)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry> = $r45 
(define-const var3916 var1290 var529-DEFAULT_METADATA_REPORT_CYCLE_REPORT) ; Statement: $r48 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Boolean DEFAULT_METADATA_REPORT_CYCLE_REPORT> 
(assert true)
(define-const var355 Bool (booleanValue/-1820462562 var3916)) ; Statement: $z10 = virtualinvoke $r48.<java.lang.Boolean: boolean booleanValue()>() 
(assert true)
(define-const var1836 Bool (getParameter/2144001655 var2066!1 "cycle-report" var355)) ; Statement: $z11 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("cycle-report", $z10) 
 ; Statement: if $z11 == 0 goto $z1 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-metadata", 0) 
(assert (= (ite var1836 1 0) 0)) ; Cond: $z11 == 0 
(assert true)
(define-const var2804 Bool (getParameter/2144001655 var2066!1 "report-metadata" (ite (= 1 0) true false))) ; Statement: $z1 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-metadata", 0) 
(declare-const var1492!16 var2993)
(assert (not (= var1492!16 null-var2993)))
(assert (= (reportMetadata/-1923175899 var1492!16) var2804)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean reportMetadata> = $z1 
(assert true)
(define-const var2367 Bool (getParameter/2144001655 var2066!1 "report-definition" (ite (= 1 1) true false))) ; Statement: $z2 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-definition", 1) 
(declare-const var1492!17 var2993)
(assert (not (= var1492!17 null-var2993)))
(assert (= (reportDefinition/-1923175899 var1492!17) var2367)) ; Statement: r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean reportDefinition> = $z2 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2993-to-var107=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.lang.Object), getClass/1258963082=([java.lang.Object], java.lang.Class), var1123_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), logger/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3535-init=([], java.util.Properties), <init>/964458484=([java.util.Properties], void), properties/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Properties), var1758-init=([], org.apache.dubbo.common.utils.NamedThreadFactory), <init>/-1889012253=([org.apache.dubbo.common.utils.NamedThreadFactory, java.lang.String, boolean], void), var1760_newFixedThreadPool/-923551937=([int, java.util.concurrent.ThreadFactory], java.util.concurrent.ExecutorService), cast-from-var1758-to-var3147=([org.apache.dubbo.common.utils.NamedThreadFactory], java.util.concurrent.ThreadFactory), reportCacheExecutor/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.concurrent.ExecutorService), var708-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-334308776=([java.util.concurrent.ConcurrentHashMap, int], void), cast-from-var708-to-var1199=([java.util.concurrent.ConcurrentHashMap], java.util.Map), allMetadataReports/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Map), var2442-init=([], java.util.concurrent.atomic.AtomicLong), <init>/1827284532=([java.util.concurrent.atomic.AtomicLong], void), lastCacheChanged/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.concurrent.atomic.AtomicLong), failedReports/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.Map), var1079-init=([], java.util.concurrent.atomic.AtomicBoolean), <init>/-1201058856=([java.util.concurrent.atomic.AtomicBoolean, boolean], void), initialized/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.util.concurrent.atomic.AtomicBoolean), setUrl/-479382679=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport, org.apache.dubbo.common.URL], void), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), applicationModel/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.rpc.model.ApplicationModel), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1657_getSystemProperty/1393069448=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), var1338_replace/553341465=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), file/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], java.io.File), loadProperties/-1005210489=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], void), syncReport/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], boolean), var685-init=([], org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry), intValue/-1815674922=([java.lang.Integer], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), <init>/-540273274=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, org.apache.dubbo.metadata.report.support.AbstractMetadataReport, int, int], void), metadataReportRetry/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry), booleanValue/-1820462562=([java.lang.Boolean], boolean), reportMetadata/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], boolean), reportDefinition/-1923175899=([org.apache.dubbo.metadata.report.support.AbstractMetadataReport], boolean)}
; {var2993=org.apache.dubbo.metadata.report.support.AbstractMetadataReport, var1492=r0, var1=org.apache.dubbo.common.URL, var2066=r10, var107=java.lang.Object, var3244=$r1, var946=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1123=org.apache.dubbo.common.logger.LoggerFactory, var802=$r2, var3535=java.util.Properties, var3930=$r3, var1758=org.apache.dubbo.common.utils.NamedThreadFactory, var3031=$r4, var1732="DubboSaveMetadataReport", var3574=1, var2784=java.util.concurrent.ExecutorService, var1760=java.util.concurrent.Executors, var3147=java.util.concurrent.ThreadFactory, var2137=$r5, var708=java.util.concurrent.ConcurrentHashMap, var3898=$r6, var1663=4, var1199=java.util.Map, var2442=java.util.concurrent.atomic.AtomicLong, var3211=$r7, var3687=$r8, var1079=java.util.concurrent.atomic.AtomicBoolean, var630=$r9, var1091=0, var3925=org.apache.dubbo.rpc.model.ApplicationModel, var3207=$r11, var3996=z0, var3013=$r12, var1657=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3423=$r13, var3637=$r14, var2184=$r16, var2525=$r15, var2547=$r17, var3322=$r20, var3395=$r18, var1338=org.apache.dubbo.common.utils.StringUtils, var3064=$r19, var2303=$r21, var2623=$r22, var2180=r23, var3263=r24, var3979=java.io.File, var3917=r43, var1289=$z9, var685=org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry, var2010=$r45, var529=org.apache.dubbo.metadata.report.support.Constants, var2562=$r46, var855=$i1, var263=$i2, var1078=$r47, var1516=$i3, var1660=$i4, var1290=java.lang.Boolean, var3916=$r48, var355=$z10, var1836=$z11, var2804=$z1, var2367=$z2}
; {org.apache.dubbo.metadata.report.support.AbstractMetadataReport=var2993, r0=var1492, org.apache.dubbo.common.URL=var1, r10=var2066, java.lang.Object=var107, $r1=var3244, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var946, org.apache.dubbo.common.logger.LoggerFactory=var1123, $r2=var802, java.util.Properties=var3535, $r3=var3930, org.apache.dubbo.common.utils.NamedThreadFactory=var1758, $r4=var3031, "DubboSaveMetadataReport"=var1732, 1=var3574, java.util.concurrent.ExecutorService=var2784, java.util.concurrent.Executors=var1760, java.util.concurrent.ThreadFactory=var3147, $r5=var2137, java.util.concurrent.ConcurrentHashMap=var708, $r6=var3898, 4=var1663, java.util.Map=var1199, java.util.concurrent.atomic.AtomicLong=var2442, $r7=var3211, $r8=var3687, java.util.concurrent.atomic.AtomicBoolean=var1079, $r9=var630, 0=var1091, org.apache.dubbo.rpc.model.ApplicationModel=var3925, $r11=var3207, z0=var3996, $r12=var3013, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1657, $r13=var3423, $r14=var3637, $r16=var2184, $r15=var2525, $r17=var2547, $r20=var3322, $r18=var3395, org.apache.dubbo.common.utils.StringUtils=var1338, $r19=var3064, $r21=var2303, $r22=var2623, r23=var2180, r24=var3263, java.io.File=var3979, r43=var3917, $z9=var1289, org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry=var685, $r45=var2010, org.apache.dubbo.metadata.report.support.Constants=var529, $r46=var2562, $i1=var855, $i2=var263, $r47=var1078, $i3=var1516, $i4=var1660, java.lang.Boolean=var1290, $r48=var3916, $z10=var355, $z11=var1836, $z1=var2804, $z2=var2367}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.support.AbstractMetadataReport;	r10 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r2 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>($r1);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r2;	$r3 = new java.util.Properties;	specialinvoke $r3.<java.util.Properties: void <init>()>();	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Properties properties> = $r3;	$r4 = new org.apache.dubbo.common.utils.NamedThreadFactory;	specialinvoke $r4.<org.apache.dubbo.common.utils.NamedThreadFactory: void <init>(java.lang.String,boolean)>("DubboSaveMetadataReport", 1);	$r5 = staticinvoke <java.util.concurrent.Executors: java.util.concurrent.ExecutorService newFixedThreadPool(int,java.util.concurrent.ThreadFactory)>(1, $r4);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.ExecutorService reportCacheExecutor> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>(int)>(4);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map allMetadataReports> = $r6;	$r7 = new java.util.concurrent.atomic.AtomicLong;	specialinvoke $r7.<java.util.concurrent.atomic.AtomicLong: void <init>()>();	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.atomic.AtomicLong lastCacheChanged> = $r7;	$r8 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r8.<java.util.concurrent.ConcurrentHashMap: void <init>(int)>(4);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.Map failedReports> = $r8;	$r9 = new java.util.concurrent.atomic.AtomicBoolean;	specialinvoke $r9.<java.util.concurrent.atomic.AtomicBoolean: void <init>(boolean)>(0);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.util.concurrent.atomic.AtomicBoolean initialized> = $r9;	virtualinvoke r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: void setUrl(org.apache.dubbo.common.URL)>(r10);	$r11 = virtualinvoke r10.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = $r11;	z0 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("file-cache", 1);	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("user.home");	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/.dubbo/dubbo-metadata-");	$r15 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-");	$r18 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r19 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>($r18, ":", "-");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".cache");	r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	r24 = virtualinvoke r10.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("file", r23);	r43 = null;	if z0 == 0 goto r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.io.File file> = r43;	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: java.io.File file> = r43;	virtualinvoke r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: void loadProperties()>();	$z9 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("sync-report", 0);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean syncReport> = $z9;	$r45 = new org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry;	$r46 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Integer DEFAULT_METADATA_REPORT_RETRY_TIMES>;	$i1 = virtualinvoke $r46.<java.lang.Integer: int intValue()>();	$i2 = virtualinvoke r10.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("retry-times", $i1);	$r47 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Integer DEFAULT_METADATA_REPORT_RETRY_PERIOD>;	$i3 = virtualinvoke $r47.<java.lang.Integer: int intValue()>();	$i4 = virtualinvoke r10.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("retry-period", $i3);	specialinvoke $r45.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry: void <init>(org.apache.dubbo.metadata.report.support.AbstractMetadataReport,int,int)>(r0, $i2, $i4);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: org.apache.dubbo.metadata.report.support.AbstractMetadataReport$MetadataReportRetry metadataReportRetry> = $r45;	$r48 = <org.apache.dubbo.metadata.report.support.Constants: java.lang.Boolean DEFAULT_METADATA_REPORT_CYCLE_REPORT>;	$z10 = virtualinvoke $r48.<java.lang.Boolean: boolean booleanValue()>();	$z11 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("cycle-report", $z10);	if $z11 == 0 goto $z1 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-metadata", 0);	$z1 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-metadata", 0);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean reportMetadata> = $z1;	$z2 = virtualinvoke r10.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("report-definition", 1);	r0.<org.apache.dubbo.metadata.report.support.AbstractMetadataReport: boolean reportDefinition> = $z2;	return
;block_num 3