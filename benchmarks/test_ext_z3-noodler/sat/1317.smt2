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

(declare-sort var25 0)
(declare-sort var2918 0)
(declare-sort var2847 0)
(declare-sort var168 0)
(declare-sort var356 0)
(declare-sort var2921 0)
(declare-sort var1228 0)
(declare-sort var102 0)
(declare-sort var1513 0)
(declare-sort var3126 0)
(declare-sort var1347 0)
(declare-sort var1615 0)
(declare-sort var2301 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun stream/-1288525013 (var1228) var2921)
(declare-fun cast-from-var2918-to-var1228 (var2918) var1228)
(declare-fun var1513_bootstrap$/1614022446 () var102)
(declare-fun var2921_map/130902797 (var2921 var102) var2921)
(declare-fun var3126_bootstrap$/-1137728663 () var102)
(declare-fun var1615_joining/-1302177485 (String) var1347)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2921_collect/-2050842585 (var2921 var1347) var2301)
(declare-fun cast-from-var2301-to-String (var2301) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var356_error/377575788 (var356 String String String String var168) void)
(declare-const null-var25 var25)
(declare-const null-var2918 var2918)
(declare-const null-var2847 var2847)
(declare-const null-var168 var168)
(declare-const var25-logger var356)
(declare-const var2531 var25) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.directory.AbstractDirectory 
(assert (not (= var2531 null-var25)))
(declare-const var548 var2918) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var548 null-var2918)))
(declare-const var304 var2847) ; Statement: r3 := @parameter1: java.lang.Runnable 
(assert (not (= var304 null-var2847)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var920 var168) ; Statement: $r5 := @caughtexception 
(assert (not (= var920 null-var168)))
(define-const var3699 var356 var25-logger) ; Statement: $r7 = <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2101 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2101)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2101!1 String)
(assert (= var2101!1 ""))
(assert true)
(define-const var3577 String (append/672562846 var2101!1 "Error occurred when refreshing router chain. The addresses from notification: ")) ; Statement: $r16 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error occurred when refreshing router chain. The addresses from notification: ") 
(declare-const var2101!2 String)
(assert (= var2101!2 (str.++ var2101!1 "Error occurred when refreshing router chain. The addresses from notification: ")))
(assert true)
(define-const var1767 var2921 (stream/-1288525013 (cast-from-var2918-to-var1228 var548))) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.stream.Stream stream()>() 
(define-const var3796 var102 var1513_bootstrap$/1614022446) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getUrl__18: java.util.function.Function bootstrap$()>() 
(define-const var2430 var2921 (var2921_map/130902797 var1767 var3796)) ; Statement: $r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8) 
(define-const var1925 var102 var3126_bootstrap$/-1137728663) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getAddress__29: java.util.function.Function bootstrap$()>() 
(define-const var890 var2921 (var2921_map/130902797 var2430 var1925)) ; Statement: $r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r10) 
(define-const var200 var1347 (var1615_joining/-1302177485 (cast-from-String-to-String ", "))) ; Statement: $r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ") 
(define-const var3529 var2301 (var2921_collect/-2050842585 var890 var200)) ; Statement: $r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12) 
(define-const var2120 String (cast-from-var2301-to-String var3529)) ; Statement: $r15 = (java.lang.String) $r14 
(assert true)
(define-const var1211 String (append/672562846 var3577 var2120)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var3577!1 String)
(assert (= var3577!1 (str.++ var3577 var2120)))
(assert true)
(define-const var513 String (toString/-2075883882 var1211)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var356_error/377575788 var3699 "99-0" "" "" var513 var920)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("99-0", "", "", $r18, $r5) 

(declare-const var3699!1 var356)
(declare-const var2056 String)
(declare-const var1769 String)
(declare-const var1769!1 String)
(declare-const var513!1 String)
(declare-const var920!1 var168)
 ; Statement: throw $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var2918-to-var1228=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.Collection), var1513_bootstrap$/1614022446=([], java.util.function.Function), var2921_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var3126_bootstrap$/-1137728663=([], java.util.function.Function), var1615_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2921_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2301-to-String=([java.lang.Object], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var356_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var25=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var2531=r0, var2918=org.apache.dubbo.rpc.cluster.router.state.BitList, var548=r1, var2847=java.lang.Runnable, var304=r3, var168=java.lang.Throwable, var920=$r5, var356=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3699=$r7, var2101=$r6, var3577=$r16, var2921=java.util.stream.Stream, var1228=java.util.Collection, var1767=$r9, var102=java.util.function.Function, var1513=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getUrl__18, var3796=$r8, var2430=$r11, var3126=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getAddress__29, var1925=$r10, var890=$r13, var1347=java.util.stream.Collector, var1615=java.util.stream.Collectors, var200=$r12, var2301=java.lang.Object, var3529=$r14, var2120=$r15, var1211=$r17, var513=$r18, var2056="99-0", var1769=""}
; {org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var25, r0=var2531, org.apache.dubbo.rpc.cluster.router.state.BitList=var2918, r1=var548, java.lang.Runnable=var2847, r3=var304, java.lang.Throwable=var168, $r5=var920, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var356, $r7=var3699, $r6=var2101, $r16=var3577, java.util.stream.Stream=var2921, java.util.Collection=var1228, $r9=var1767, java.util.function.Function=var102, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getUrl__18=var1513, $r8=var3796, $r11=var2430, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getAddress__29=var3126, $r10=var1925, $r13=var890, java.util.stream.Collector=var1347, java.util.stream.Collectors=var1615, $r12=var200, java.lang.Object=var2301, $r14=var3529, $r15=var2120, $r17=var1211, $r18=var513, "99-0"=var2056, ""=var1769}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.directory.AbstractDirectory;	r1 := @parameter0: org.apache.dubbo.rpc.cluster.router.state.BitList;	r3 := @parameter1: java.lang.Runnable;	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Error occurred when refreshing router chain. The addresses from notification: ");	$r9 = virtualinvoke r1.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.stream.Stream stream()>();	$r8 = staticinvoke <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getUrl__18: java.util.function.Function bootstrap$()>();	$r11 = interfaceinvoke $r9.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r8);	$r10 = staticinvoke <org.apache.dubbo.rpc.cluster.directory.AbstractDirectory$getAddress__29: java.util.function.Function bootstrap$()>();	$r13 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r10);	$r12 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>(", ");	$r14 = interfaceinvoke $r13.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r12);	$r15 = (java.lang.String) $r14;	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("99-0", "", "", $r18, $r5);	throw $r5
;block_num 2