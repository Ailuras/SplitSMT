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

(declare-sort var1813 0)
(declare-sort var1153 0)
(declare-sort var1164 0)
(declare-sort var3806 0)
(declare-sort var1658 0)
(declare-sort var2648 0)
(declare-sort var3935 0)
(declare-sort var1235 0)
(declare-sort var2330 0)
(declare-sort var2364 0)
(declare-sort var633 0)
(declare-sort var1655 0)
(declare-sort var2401 0)
(declare-sort var35 0)
(declare-sort var986 0)
(declare-sort var685 0)
(declare-sort var3068 0)
(declare-sort var3557 0)
(declare-sort var567 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun var3806-init () var3806)
(declare-fun <init>/-788617071 (var3806 String String) void)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun javaFileManager/-2136503041 (var1813) var1658)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun putFileForInput/372991472 (var1658 var2648 String String var3935) void)
(declare-fun cast-from-var3806-to-var3935 (var3806) var3935)
(declare-fun compiler/-2136503041 (var1813) var1235)
(declare-fun diagnosticCollector/-2136503041 (var1813) var2330)
(declare-fun options/-2136503041 (var1813) var2364)
(declare-fun var633_singletonList/684126186 (var1655) var2364)
(declare-fun cast-from-var3806-to-var1655 (var3806) var1655)
(declare-fun var1235_getTask/763094539 (var1235 var35 var986 var685 var3068 var3068 var3068) var2401)
(declare-fun cast-from-var1658-to-var986 (var1658) var986)
(declare-fun cast-from-var2330-to-var685 (var2330) var685)
(declare-fun cast-from-var2364-to-var3068 (var2364) var3068)
(declare-fun var2401_call/-916517215 (var2401) var3557)
(declare-fun var567-init () var567)
(declare-fun getDiagnostics/-246447062 (var2330) var2364)
(declare-fun append/-1031950772 (String var1655) String)
(declare-fun cast-from-var2364-to-var1655 (var2364) var1655)
(declare-fun <init>/-1092629202 (var567 String) void)
(declare-const null-var1813 var1813)
(declare-const null-var1153 var1153)
(declare-const null-String String)
(declare-const var2648-SOURCE_PATH var2648)
(declare-const null-var35 var35)
(declare-const null-var3068 var3068)
(declare-const null-var3557 var3557)
(declare-const var3962 var1813) ; Statement: r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler 
(assert (not (= var3962 null-var1813)))
(declare-const var290 var1153) ; Statement: r29 := @parameter0: java.lang.ClassLoader 
(assert (not (= var290 null-var1153)))
(declare-const var1616 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1616 null-String)))
(declare-const var3638 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3638 null-String)))
(assert true)
(define-const var1925 Int (lastIndexOf/-1292097097 var1616 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46) 
 ; Statement: if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert (not (>= var1925 0))) ; Negate: Cond: i0 >= 0  
(define-const var27 String "") ; Statement: $r30 = "" 
 ; Statement: goto [?= r1 = $r30] 
(assert true) ; Non Conditional
(define-const var2051 String var27) ; Statement: r1 = $r30 
 ; Statement: if i0 >= 0 goto $i1 = i0 + 1 
(assert (not (>= var1925 0))) ; Negate: Cond: i0 >= 0  
(define-const var595 String var1616) ; Statement: $r31 = r0 
 ; Statement: goto [?= $r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl] 
(assert true) ; Non Conditional
(define-const var2782 var3806 var3806-init) ; Statement: $r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl 
(assert true)
;(assert (<init>/-788617071 var2782 var595 (cast-from-String-to-String var3638))) ; Statement: specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3) 

(declare-const var2782!1 var3806)
(declare-const var595!1 String)
(declare-const var3638!1 String)
(define-const var1842 var1658 (javaFileManager/-2136503041 var3962)) ; Statement: $r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var113 var2648 var2648-SOURCE_PATH) ; Statement: $r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH> 
(define-const var138 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var138)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var138!1 String)
(assert (= var138!1 ""))
(assert true)
(define-const var3765 String (append/672562846 var138!1 var595!1)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31) 
(declare-const var138!2 String)
(assert (= var138!2 (str.++ var138!1 var595!1)))
(assert true)
(define-const var3180 String (append/672562846 var3765 ".java")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java") 
(declare-const var3765!1 String)
(assert (= var3765!1 (str.++ var3765 ".java")))
(assert true)
(define-const var3818 String (toString/-2075883882 var3180)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (putFileForInput/372991472 var1842 var113 var2051 var3818 (cast-from-var3806-to-var3935 var2782!1))) ; Statement: virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2) 

(declare-const var1842!1 var1658)
(declare-const var113!1 var2648)
(declare-const var2051!1 String)
(declare-const var3818!1 String)
(declare-const var2782!2 var3806)
(define-const var3559 var1235 (compiler/-2136503041 var3962)) ; Statement: $r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler> 
(define-const var587 var1658 (javaFileManager/-2136503041 var3962)) ; Statement: $r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var752 var2330 (diagnosticCollector/-2136503041 var3962)) ; Statement: $r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(define-const var3254 var2364 (options/-2136503041 var3962)) ; Statement: $r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options> 
(define-const var3905 var2364 (var633_singletonList/684126186 (cast-from-var3806-to-var1655 var2782!2))) ; Statement: $r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2) 
(define-const var3441 var2401 (var1235_getTask/763094539 var3559 null-var35 (cast-from-var1658-to-var986 var587) (cast-from-var2330-to-var685 var752) (cast-from-var2364-to-var3068 var3254) null-var3068 (cast-from-var2364-to-var3068 var3905))) ; Statement: $r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15) 
(define-const var1849 var3557 (var2401_call/-916517215 var3441)) ; Statement: $r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>() 
 ; Statement: if $r28 == null goto $r17 = new java.lang.IllegalStateException 
(assert (= var1849 null-var3557)) ; Cond: $r28 == null 
(define-const var1387 var567 var567-init) ; Statement: $r17 = new java.lang.IllegalStateException 
(define-const var1862 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1862)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1862!1 String)
(assert (= var1862!1 ""))
(assert true)
(define-const var3763 String (append/672562846 var1862!1 "Compilation failed. class: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ") 
(declare-const var1862!2 String)
(assert (= var1862!2 (str.++ var1862!1 "Compilation failed. class: ")))
(assert true)
(define-const var2141 String (append/672562846 var3763 var1616)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3763!1 String)
(assert (= var3763!1 (str.++ var3763 var1616)))
(assert true)
(define-const var2952 String (append/672562846 var2141 ", diagnostics: ")) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ") 
(declare-const var2141!1 String)
(assert (= var2141!1 (str.++ var2141 ", diagnostics: ")))
(define-const var3730 var2330 (diagnosticCollector/-2136503041 var3962)) ; Statement: $r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(assert true)
(define-const var37 var2364 (getDiagnostics/-246447062 var3730)) ; Statement: $r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>() 
(assert true)
(define-const var3297 String (append/-1031950772 var2952 (cast-from-var2364-to-var1655 var37))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22) 
(declare-const var2952!1 String)
(assert (str.prefixof var2952 var2952!1))
(assert true)
(define-const var2257 String (toString/-2075883882 var3297)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var1387 var2257)) ; Statement: specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25) 

(declare-const var1387!1 var567)
(declare-const var2257!1 String)
 ; Statement: throw $r17 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), var3806-init=([], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl), <init>/-788617071=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, java.lang.String, java.lang.CharSequence], void), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), javaFileManager/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), putFileForInput/372991472=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, javax.tools.StandardLocation, java.lang.String, java.lang.String, javax.tools.JavaFileObject], void), cast-from-var3806-to-var3935=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], javax.tools.JavaFileObject), compiler/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.JavaCompiler), diagnosticCollector/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.DiagnosticCollector), options/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], java.util.List), var633_singletonList/684126186=([java.lang.Object], java.util.List), cast-from-var3806-to-var1655=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], java.lang.Object), var1235_getTask/763094539=([javax.tools.JavaCompiler, java.io.Writer, javax.tools.JavaFileManager, javax.tools.DiagnosticListener, java.lang.Iterable, java.lang.Iterable, java.lang.Iterable], javax.tools.JavaCompiler$CompilationTask), cast-from-var1658-to-var986=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl], javax.tools.JavaFileManager), cast-from-var2330-to-var685=([javax.tools.DiagnosticCollector], javax.tools.DiagnosticListener), cast-from-var2364-to-var3068=([java.util.List], java.lang.Iterable), var2401_call/-916517215=([javax.tools.JavaCompiler$CompilationTask], java.lang.Boolean), var567-init=([], java.lang.IllegalStateException), getDiagnostics/-246447062=([javax.tools.DiagnosticCollector], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2364-to-var1655=([java.util.List], java.lang.Object), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1813=org.apache.dubbo.common.compiler.support.JdkCompiler, var3962=r4, var1153=java.lang.ClassLoader, var290=r29, var1616=r0, var1164=null_type, var3638=r3, var1925=i0, var27=$r30, var2051=r1, var595=$r31, var3806=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, var2782=$r2, var1658=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, var1842=$r6, var2648=javax.tools.StandardLocation, var113=$r7, var138=$r5, var3765=$r8, var3180=$r9, var3818=$r10, var3935=javax.tools.JavaFileObject, var1235=javax.tools.JavaCompiler, var3559=$r11, var587=$r12, var2330=javax.tools.DiagnosticCollector, var752=$r13, var2364=java.util.List, var3254=$r14, var633=java.util.Collections, var1655=java.lang.Object, var3905=$r15, var2401=javax.tools.JavaCompiler$CompilationTask, var35=java.io.Writer, var986=javax.tools.JavaFileManager, var685=javax.tools.DiagnosticListener, var3068=java.lang.Iterable, var3441=$r16, var3557=java.lang.Boolean, var1849=$r28, var567=java.lang.IllegalStateException, var1387=$r17, var1862=$r18, var3763=$r19, var2141=$r20, var2952=$r23, var3730=$r21, var37=$r22, var3297=$r24, var2257=$r25}
; {org.apache.dubbo.common.compiler.support.JdkCompiler=var1813, r4=var3962, java.lang.ClassLoader=var1153, r29=var290, r0=var1616, null_type=var1164, r3=var3638, i0=var1925, $r30=var27, r1=var2051, $r31=var595, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl=var3806, $r2=var2782, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl=var1658, $r6=var1842, javax.tools.StandardLocation=var2648, $r7=var113, $r5=var138, $r8=var3765, $r9=var3180, $r10=var3818, javax.tools.JavaFileObject=var3935, javax.tools.JavaCompiler=var1235, $r11=var3559, $r12=var587, javax.tools.DiagnosticCollector=var2330, $r13=var752, java.util.List=var2364, $r14=var3254, java.util.Collections=var633, java.lang.Object=var1655, $r15=var3905, javax.tools.JavaCompiler$CompilationTask=var2401, java.io.Writer=var35, javax.tools.JavaFileManager=var986, javax.tools.DiagnosticListener=var685, java.lang.Iterable=var3068, $r16=var3441, java.lang.Boolean=var3557, $r28=var1849, java.lang.IllegalStateException=var567, $r17=var1387, $r18=var1862, $r19=var3763, $r20=var2141, $r23=var2952, $r21=var3730, $r22=var37, $r24=var3297, $r25=var2257}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler;	r29 := @parameter0: java.lang.ClassLoader;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46);	if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r30 = "";	goto [?= r1 = $r30];	r1 = $r30;	if i0 >= 0 goto $i1 = i0 + 1;	$r31 = r0;	goto [?= $r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl];	$r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl;	specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3);	$r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2);	$r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler>;	$r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options>;	$r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2);	$r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15);	$r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>();	if $r28 == null goto $r17 = new java.lang.IllegalStateException;	$r17 = new java.lang.IllegalStateException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ");	$r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25);	throw $r17
;block_num 6