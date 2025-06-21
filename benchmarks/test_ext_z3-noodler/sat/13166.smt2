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

(declare-sort var1780 0)
(declare-sort var3915 0)
(declare-sort var913 0)
(declare-sort var1052 0)
(declare-sort var1173 0)
(declare-sort var513 0)
(declare-sort var1389 0)
(declare-sort var2418 0)
(declare-sort var1064 0)
(declare-sort var656 0)
(declare-sort var473 0)
(declare-sort var3765 0)
(declare-sort var3482 0)
(declare-sort var3764 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var513!class ClassObject)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1780_getSystemProperty/1393069448 (String) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun arr-var913-init () (Array Int var913))
(declare-fun var513_of/692999526 ((Array Int var1173)) (Array Int var1173))
(declare-fun cast-from-__Array__Int__var913__-to-__Array__Int__var1173__ ((Array Int var913)) (Array Int var1173))
(declare-fun cast-from-__Array__Int__var1173__-to-__Array__Int__var913__ ((Array Int var1173)) (Array Int var913))
(declare-fun var2418_getErrorTypeAwareLogger/453021605 (ClassObject) var1389)
(declare-fun var1064-init () var1064)
(declare-fun <init>/-818137822 (var1064) void)
(declare-fun var473_unmodifiableMap/-1864031675 (var656) var656)
(declare-fun cast-from-var1064-to-var656 (var1064) var656)
(declare-fun var513_newWatchService/1814668481 () var3765)
(declare-fun var513_detectPoolingBasedWatchService/2105357113 (var3765) Bool)
(declare-fun var513_initWatchEventModifiers/-2051681812 () (Array Int var3482))
(declare-fun var513_initDelay/-2012723750 ((Array Int var3482)) Int)
(declare-fun var513_newWatchEventsLoopThreadPool/-1952139675 () var3764)
(declare-const var3915-separator String)
(declare-const var1052-ENTRY_CREATE var913)
(declare-const null-__Array__Int__var913__ (Array Int var913))
(declare-const var1052-ENTRY_DELETE var913)
(declare-const var1052-ENTRY_MODIFY var913)
(declare-const var513-watchService var3765)
(declare-const var513-MODIFIERS (Array Int var3482))
(define-const var1029 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1029)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1029!1 String)
(assert (= var1029!1 ""))
(define-const var2370 String (var1780_getSystemProperty/1393069448 "user.home")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("user.home") 
(assert true)
(define-const var3814 String (append/672562846 var1029!1 var2370)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var1029!2 String)
(assert (= var1029!2 (str.++ var1029!1 var2370)))
(define-const var2569 String var3915-separator) ; Statement: $r2 = <java.io.File: java.lang.String separator> 
(assert true)
(define-const var3729 String (append/672562846 var3814 var2569)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3814!1 String)
(assert (= var3814!1 (str.++ var3814 var2569)))
(assert true)
(define-const var3084 String (append/672562846 var3729 ".dubbo")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".dubbo") 
(declare-const var3729!1 String)
(assert (= var3729!1 (str.++ var3729 ".dubbo")))
(define-const var651 String var3915-separator) ; Statement: $r5 = <java.io.File: java.lang.String separator> 
(assert true)
(define-const var3702 String (append/672562846 var3084 var651)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var3084!1 String)
(assert (= var3084!1 (str.++ var3084 var651)))
(assert true)
(define-const var870 String (append/672562846 var3702 "config-center")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("config-center") 
(declare-const var3702!1 String)
(assert (= var3702!1 (str.++ var3702 "config-center")))
(assert true)
(define-const var1784 String (toString/-2075883882 var870)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3514 String var1784) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH> = $r9 
(define-const var2198 (Array Int var913) arr-var913-init) ; Statement: $r10 = newarray (java.nio.file.WatchEvent$Kind)[3] 
(define-const var2791 var913 var1052-ENTRY_CREATE) ; Statement: $r11 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_CREATE> 
(declare-const var2198!1 (Array Int var913))
(assert (not (= var2198!1 null-__Array__Int__var913__)))
(assert (= (select var2198!1 0) var2791)) ; Statement: $r10[0] = $r11 
(define-const var3278 var913 var1052-ENTRY_DELETE) ; Statement: $r12 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_DELETE> 
(declare-const var2198!2 (Array Int var913))
(assert (not (= var2198!2 null-__Array__Int__var913__)))
(assert (= (select var2198!2 1) var3278)) ; Statement: $r10[1] = $r12 
(define-const var794 var913 var1052-ENTRY_MODIFY) ; Statement: $r13 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_MODIFY> 
(declare-const var2198!3 (Array Int var913))
(assert (not (= var2198!3 null-__Array__Int__var913__)))
(assert (= (select var2198!3 2) var794)) ; Statement: $r10[2] = $r13 
(define-const var2735 (Array Int var1173) (var513_of/692999526 (cast-from-__Array__Int__var913__-to-__Array__Int__var1173__ var2198!3))) ; Statement: $r14 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Object[] of(java.lang.Object[])>($r10) 
(define-const var2904 (Array Int var913) (cast-from-__Array__Int__var1173__-to-__Array__Int__var913__ var2735)) ; Statement: $r15 = (java.nio.file.WatchEvent$Kind[]) $r14 
(define-const var3591 (Array Int var913) var2904) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Kind[] INTEREST_PATH_KINDS> = $r15 
(define-const var3512 var1389 (var2418_getErrorTypeAwareLogger/453021605 var513!class)) ; Statement: $r16 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/configcenter/file/FileSystemDynamicConfiguration;") 
(define-const var3914 var1389 var3512) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r16 
(define-const var389 var1064 var1064-init) ; Statement: $r17 = new org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1 
(assert true)
;(assert (<init>/-818137822 var389)) ; Statement: specialinvoke $r17.<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1: void <init>()>() 

(declare-const var389!1 var1064)
(define-const var2875 var656 (var473_unmodifiableMap/-1864031675 (cast-from-var1064-to-var656 var389!1))) ; Statement: $r18 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r17) 
(define-const var602 var656 var2875) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Map CONFIG_CHANGE_TYPES_MAP> = $r18 
(define-const var1317 var3765 var513_newWatchService/1814668481) ; Statement: $r19 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional newWatchService()>() 
(define-const var3531 var3765 var1317) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService> = $r19 
(define-const var1309 var3765 var513-watchService) ; Statement: $r20 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService> 
(define-const var3093 Bool (var513_detectPoolingBasedWatchService/2105357113 var1309)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean detectPoolingBasedWatchService(java.util.Optional)>($r20) 
(define-const var3973 Bool var3093) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean BASED_POOLING_WATCH_SERVICE> = $z0 
(define-const var624 (Array Int var3482) var513_initWatchEventModifiers/-2051681812) ; Statement: $r21 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] initWatchEventModifiers()>() 
(define-const var3237 (Array Int var3482) var624) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS> = $r21 
(define-const var2853 (Array Int var3482) var513-MODIFIERS) ; Statement: $r22 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS> 
(define-const var3219 Int (var513_initDelay/-2012723750 var2853)) ; Statement: $r23 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer initDelay(java.nio.file.WatchEvent$Modifier[])>($r22) 
(define-const var3596 Int var3219) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer DELAY> = $r23 
(define-const var899 var3764 var513_newWatchEventsLoopThreadPool/-1952139675) ; Statement: $r24 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor newWatchEventsLoopThreadPool()>() 
(define-const var2338 var3764 var899) ; Statement: <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor WATCH_EVENTS_LOOP_THREAD_POOL> = $r24 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1780_getSystemProperty/1393069448=([java.lang.String], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), arr-var913-init=([], java.nio.file.WatchEvent$Kind[]), var513_of/692999526=([java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__var913__-to-__Array__Int__var1173__=([java.nio.file.WatchEvent$Kind[]], java.lang.Object[]), cast-from-__Array__Int__var1173__-to-__Array__Int__var913__=([java.lang.Object[]], java.nio.file.WatchEvent$Kind[]), var2418_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var1064-init=([], org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1), <init>/-818137822=([org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1], void), var473_unmodifiableMap/-1864031675=([java.util.Map], java.util.Map), cast-from-var1064-to-var656=([org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1], java.util.Map), var513_newWatchService/1814668481=([], java.util.Optional), var513_detectPoolingBasedWatchService/2105357113=([java.util.Optional], boolean), var513_initWatchEventModifiers/-2051681812=([], java.nio.file.WatchEvent$Modifier[]), var513_initDelay/-2012723750=([java.nio.file.WatchEvent$Modifier[]], java.lang.Integer), var513_newWatchEventsLoopThreadPool/-1952139675=([], java.util.concurrent.ThreadPoolExecutor)}
; {var1029=$r0, var1780=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2370=$r1, var3814=$r3, var3915=java.io.File, var2569=$r2, var3729=$r4, var3084=$r6, var651=$r5, var3702=$r7, var870=$r8, var1784=$r9, var3514=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH>, var913=java.nio.file.WatchEvent$Kind, var2198=$r10, var1052=java.nio.file.StandardWatchEventKinds, var2791=$r11, var3278=$r12, var794=$r13, var1173=java.lang.Object, var513=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration, var2735=$r14, var2904=$r15, var3591=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Kind[] INTEREST_PATH_KINDS>, var1389=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2418=org.apache.dubbo.common.logger.LoggerFactory, var3512=$r16, var3914=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>, var1064=org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1, var389=$r17, var656=java.util.Map, var473=java.util.Collections, var2875=$r18, var602=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Map CONFIG_CHANGE_TYPES_MAP>, var3765=java.util.Optional, var1317=$r19, var3531=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService>, var1309=$r20, var3093=$z0, var3973=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean BASED_POOLING_WATCH_SERVICE>, var3482=java.nio.file.WatchEvent$Modifier, var624=$r21, var3237=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS>, var2853=$r22, var3219=$r23, var3596=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer DELAY>, var3764=java.util.concurrent.ThreadPoolExecutor, var899=$r24, var2338=<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor WATCH_EVENTS_LOOP_THREAD_POOL>}
; {$r0=var1029, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1780, $r1=var2370, $r3=var3814, java.io.File=var3915, $r2=var2569, $r4=var3729, $r6=var3084, $r5=var651, $r7=var3702, $r8=var870, $r9=var1784, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH>=var3514, java.nio.file.WatchEvent$Kind=var913, $r10=var2198, java.nio.file.StandardWatchEventKinds=var1052, $r11=var2791, $r12=var3278, $r13=var794, java.lang.Object=var1173, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration=var513, $r14=var2735, $r15=var2904, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Kind[] INTEREST_PATH_KINDS>=var3591, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1389, org.apache.dubbo.common.logger.LoggerFactory=var2418, $r16=var3512, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>=var3914, org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1=var1064, $r17=var389, java.util.Map=var656, java.util.Collections=var473, $r18=var2875, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Map CONFIG_CHANGE_TYPES_MAP>=var602, java.util.Optional=var3765, $r19=var1317, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService>=var3531, $r20=var1309, $z0=var3093, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean BASED_POOLING_WATCH_SERVICE>=var3973, java.nio.file.WatchEvent$Modifier=var3482, $r21=var624, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS>=var3237, $r22=var2853, $r23=var3219, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer DELAY>=var3596, java.util.concurrent.ThreadPoolExecutor=var3764, $r24=var899, <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor WATCH_EVENTS_LOOP_THREAD_POOL>=var2338}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts $r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("user.home");	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	$r2 = <java.io.File: java.lang.String separator>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".dubbo");	$r5 = <java.io.File: java.lang.String separator>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("config-center");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.String DEFAULT_CONFIG_CENTER_DIR_PATH> = $r9;	$r10 = newarray (java.nio.file.WatchEvent$Kind)[3];	$r11 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_CREATE>;	$r10[0] = $r11;	$r12 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_DELETE>;	$r10[1] = $r12;	$r13 = <java.nio.file.StandardWatchEventKinds: java.nio.file.WatchEvent$Kind ENTRY_MODIFY>;	$r10[2] = $r13;	$r14 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Object[] of(java.lang.Object[])>($r10);	$r15 = (java.nio.file.WatchEvent$Kind[]) $r14;	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Kind[] INTEREST_PATH_KINDS> = $r15;	$r16 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/config/configcenter/file/FileSystemDynamicConfiguration;");	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r16;	$r17 = new org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1;	specialinvoke $r17.<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration$1: void <init>()>();	$r18 = staticinvoke <java.util.Collections: java.util.Map unmodifiableMap(java.util.Map)>($r17);	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Map CONFIG_CHANGE_TYPES_MAP> = $r18;	$r19 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional newWatchService()>();	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService> = $r19;	$r20 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.Optional watchService>;	$z0 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean detectPoolingBasedWatchService(java.util.Optional)>($r20);	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: boolean BASED_POOLING_WATCH_SERVICE> = $z0;	$r21 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] initWatchEventModifiers()>();	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS> = $r21;	$r22 = <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.nio.file.WatchEvent$Modifier[] MODIFIERS>;	$r23 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer initDelay(java.nio.file.WatchEvent$Modifier[])>($r22);	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.lang.Integer DELAY> = $r23;	$r24 = staticinvoke <org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor newWatchEventsLoopThreadPool()>();	<org.apache.dubbo.common.config.configcenter.file.FileSystemDynamicConfiguration: java.util.concurrent.ThreadPoolExecutor WATCH_EVENTS_LOOP_THREAD_POOL> = $r24;	return
;block_num 1