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

(declare-sort var2997 0)
(declare-sort var890 0)
(declare-sort var2031 0)
(declare-sort var3526 0)
(declare-sort var3708 0)
(declare-sort var1201 0)
(declare-sort var1129 0)
(declare-sort var459 0)
(declare-sort var2566 0)
(declare-sort var2470 0)
(declare-sort var2013 0)
(declare-sort var56 0)
(declare-sort var1956 0)
(declare-sort var3238 0)
(declare-sort var2621 0)
(declare-sort var1518 0)
(declare-sort var2340 0)
(declare-sort var2219 0)
(declare-sort var142 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun var3526-init () var3526)
(declare-fun <init>/-788617071 (var3526 String String) void)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun javaFileManager/-2136503041 (var2997) var3708)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun putFileForInput/372991472 (var3708 var1201 String String var1129) void)
(declare-fun cast-from-var3526-to-var1129 (var3526) var1129)
(declare-fun compiler/-2136503041 (var2997) var459)
(declare-fun diagnosticCollector/-2136503041 (var2997) var2566)
(declare-fun options/-2136503041 (var2997) var2470)
(declare-fun var2013_singletonList/684126186 (var56) var2470)
(declare-fun cast-from-var3526-to-var56 (var3526) var56)
(declare-fun var459_getTask/763094539 (var459 var3238 var2621 var1518 var2340 var2340 var2340) var1956)
(declare-fun cast-from-var3708-to-var2621 (var3708) var2621)
(declare-fun cast-from-var2566-to-var1518 (var2566) var1518)
(declare-fun cast-from-var2470-to-var2340 (var2470) var2340)
(declare-fun var1956_call/-916517215 (var1956) var2219)
(declare-fun var142-init () var142)
(declare-fun getDiagnostics/-246447062 (var2566) var2470)
(declare-fun append/-1031950772 (String var56) String)
(declare-fun cast-from-var2470-to-var56 (var2470) var56)
(declare-fun <init>/-1092629202 (var142 String) void)
(declare-const null-var2997 var2997)
(declare-const null-var890 var890)
(declare-const null-String String)
(declare-const var1201-SOURCE_PATH var1201)
(declare-const null-var3238 var3238)
(declare-const null-var2340 var2340)
(declare-const null-var2219 var2219)
(declare-const var3023 var2997) ; Statement: r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler 
(assert (not (= var3023 null-var2997)))
(declare-const var2206 var890) ; Statement: r29 := @parameter0: java.lang.ClassLoader 
(assert (not (= var2206 null-var890)))
(declare-const var1789 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1789 null-String)))
(declare-const var44 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var44 null-String)))
(assert true)
(define-const var2179 Int (lastIndexOf/-1292097097 var1789 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46) 
 ; Statement: if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert (>= var2179 0)) ; Cond: i0 >= 0 
(assert (and true (and (>= 0 0) (>= (str.len var1789) var2179) (>= var2179 0))))
(define-const var1124 String (substring/-1240304868 var1789 0 var2179)) ; Statement: $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert true) ; Non Conditional
(define-const var1508 String var1124) ; Statement: r1 = $r30 
 ; Statement: if i0 >= 0 goto $i1 = i0 + 1 
(assert (>= var2179 0)) ; Cond: i0 >= 0 
(define-const var2611 Int (+ var2179 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var2611 0) (>= (str.len var1789) var2611))))
(define-const var2887 String (substring/850833817 var1789 var2611)) ; Statement: $r31 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(assert true) ; Non Conditional
(define-const var1759 var3526 var3526-init) ; Statement: $r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl 
(assert true)
;(assert (<init>/-788617071 var1759 var2887 (cast-from-String-to-String var44))) ; Statement: specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3) 

(declare-const var1759!1 var3526)
(declare-const var2887!1 String)
(declare-const var44!1 String)
(define-const var1330 var3708 (javaFileManager/-2136503041 var3023)) ; Statement: $r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var1495 var1201 var1201-SOURCE_PATH) ; Statement: $r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH> 
(define-const var436 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var436)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var436!1 String)
(assert (= var436!1 ""))
(assert true)
(define-const var3841 String (append/672562846 var436!1 var2887!1)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31) 
(declare-const var436!2 String)
(assert (= var436!2 (str.++ var436!1 var2887!1)))
(assert true)
(define-const var3936 String (append/672562846 var3841 ".java")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java") 
(declare-const var3841!1 String)
(assert (= var3841!1 (str.++ var3841 ".java")))
(assert true)
(define-const var2471 String (toString/-2075883882 var3936)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (putFileForInput/372991472 var1330 var1495 var1508 var2471 (cast-from-var3526-to-var1129 var1759!1))) ; Statement: virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2) 

(declare-const var1330!1 var3708)
(declare-const var1495!1 var1201)
(declare-const var1508!1 String)
(declare-const var2471!1 String)
(declare-const var1759!2 var3526)
(define-const var1737 var459 (compiler/-2136503041 var3023)) ; Statement: $r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler> 
(define-const var2061 var3708 (javaFileManager/-2136503041 var3023)) ; Statement: $r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var2868 var2566 (diagnosticCollector/-2136503041 var3023)) ; Statement: $r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(define-const var1252 var2470 (options/-2136503041 var3023)) ; Statement: $r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options> 
(define-const var2504 var2470 (var2013_singletonList/684126186 (cast-from-var3526-to-var56 var1759!2))) ; Statement: $r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2) 
(define-const var3774 var1956 (var459_getTask/763094539 var1737 null-var3238 (cast-from-var3708-to-var2621 var2061) (cast-from-var2566-to-var1518 var2868) (cast-from-var2470-to-var2340 var1252) null-var2340 (cast-from-var2470-to-var2340 var2504))) ; Statement: $r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15) 
(define-const var1538 var2219 (var1956_call/-916517215 var3774)) ; Statement: $r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>() 
 ; Statement: if $r28 == null goto $r17 = new java.lang.IllegalStateException 
(assert (= var1538 null-var2219)) ; Cond: $r28 == null 
(define-const var2609 var142 var142-init) ; Statement: $r17 = new java.lang.IllegalStateException 
(define-const var1280 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1280)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1280!1 String)
(assert (= var1280!1 ""))
(assert true)
(define-const var2404 String (append/672562846 var1280!1 "Compilation failed. class: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ") 
(declare-const var1280!2 String)
(assert (= var1280!2 (str.++ var1280!1 "Compilation failed. class: ")))
(assert true)
(define-const var2922 String (append/672562846 var2404 var1789)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2404!1 String)
(assert (= var2404!1 (str.++ var2404 var1789)))
(assert true)
(define-const var1517 String (append/672562846 var2922 ", diagnostics: ")) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ") 
(declare-const var2922!1 String)
(assert (= var2922!1 (str.++ var2922 ", diagnostics: ")))
(define-const var2762 var2566 (diagnosticCollector/-2136503041 var3023)) ; Statement: $r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(assert true)
(define-const var1551 var2470 (getDiagnostics/-246447062 var2762)) ; Statement: $r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>() 
(assert true)
(define-const var447 String (append/-1031950772 var1517 (cast-from-var2470-to-var56 var1551))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22) 
(declare-const var1517!1 String)
(assert (str.prefixof var1517 var1517!1))
(assert true)
(define-const var1690 String (toString/-2075883882 var447)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var2609 var1690)) ; Statement: specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25) 

(declare-const var2609!1 var142)
(declare-const var1690!1 String)
 ; Statement: throw $r17 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), var3526-init=([], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl), <init>/-788617071=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, java.lang.String, java.lang.CharSequence], void), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), javaFileManager/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), putFileForInput/372991472=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, javax.tools.StandardLocation, java.lang.String, java.lang.String, javax.tools.JavaFileObject], void), cast-from-var3526-to-var1129=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], javax.tools.JavaFileObject), compiler/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.JavaCompiler), diagnosticCollector/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.DiagnosticCollector), options/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], java.util.List), var2013_singletonList/684126186=([java.lang.Object], java.util.List), cast-from-var3526-to-var56=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], java.lang.Object), var459_getTask/763094539=([javax.tools.JavaCompiler, java.io.Writer, javax.tools.JavaFileManager, javax.tools.DiagnosticListener, java.lang.Iterable, java.lang.Iterable, java.lang.Iterable], javax.tools.JavaCompiler$CompilationTask), cast-from-var3708-to-var2621=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl], javax.tools.JavaFileManager), cast-from-var2566-to-var1518=([javax.tools.DiagnosticCollector], javax.tools.DiagnosticListener), cast-from-var2470-to-var2340=([java.util.List], java.lang.Iterable), var1956_call/-916517215=([javax.tools.JavaCompiler$CompilationTask], java.lang.Boolean), var142-init=([], java.lang.IllegalStateException), getDiagnostics/-246447062=([javax.tools.DiagnosticCollector], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2470-to-var56=([java.util.List], java.lang.Object), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2997=org.apache.dubbo.common.compiler.support.JdkCompiler, var3023=r4, var890=java.lang.ClassLoader, var2206=r29, var1789=r0, var2031=null_type, var44=r3, var2179=i0, var1124=$r30, var1508=r1, var2611=$i1, var2887=$r31, var3526=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, var1759=$r2, var3708=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, var1330=$r6, var1201=javax.tools.StandardLocation, var1495=$r7, var436=$r5, var3841=$r8, var3936=$r9, var2471=$r10, var1129=javax.tools.JavaFileObject, var459=javax.tools.JavaCompiler, var1737=$r11, var2061=$r12, var2566=javax.tools.DiagnosticCollector, var2868=$r13, var2470=java.util.List, var1252=$r14, var2013=java.util.Collections, var56=java.lang.Object, var2504=$r15, var1956=javax.tools.JavaCompiler$CompilationTask, var3238=java.io.Writer, var2621=javax.tools.JavaFileManager, var1518=javax.tools.DiagnosticListener, var2340=java.lang.Iterable, var3774=$r16, var2219=java.lang.Boolean, var1538=$r28, var142=java.lang.IllegalStateException, var2609=$r17, var1280=$r18, var2404=$r19, var2922=$r20, var1517=$r23, var2762=$r21, var1551=$r22, var447=$r24, var1690=$r25}
; {org.apache.dubbo.common.compiler.support.JdkCompiler=var2997, r4=var3023, java.lang.ClassLoader=var890, r29=var2206, r0=var1789, null_type=var2031, r3=var44, i0=var2179, $r30=var1124, r1=var1508, $i1=var2611, $r31=var2887, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl=var3526, $r2=var1759, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl=var3708, $r6=var1330, javax.tools.StandardLocation=var1201, $r7=var1495, $r5=var436, $r8=var3841, $r9=var3936, $r10=var2471, javax.tools.JavaFileObject=var1129, javax.tools.JavaCompiler=var459, $r11=var1737, $r12=var2061, javax.tools.DiagnosticCollector=var2566, $r13=var2868, java.util.List=var2470, $r14=var1252, java.util.Collections=var2013, java.lang.Object=var56, $r15=var2504, javax.tools.JavaCompiler$CompilationTask=var1956, java.io.Writer=var3238, javax.tools.JavaFileManager=var2621, javax.tools.DiagnosticListener=var1518, java.lang.Iterable=var2340, $r16=var3774, java.lang.Boolean=var2219, $r28=var1538, java.lang.IllegalStateException=var142, $r17=var2609, $r18=var1280, $r19=var2404, $r20=var2922, $r23=var1517, $r21=var2762, $r22=var1551, $r24=var447, $r25=var1690}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler;	r29 := @parameter0: java.lang.ClassLoader;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46);	if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	r1 = $r30;	if i0 >= 0 goto $i1 = i0 + 1;	$i1 = i0 + 1;	$r31 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	$r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl;	specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3);	$r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2);	$r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler>;	$r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options>;	$r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2);	$r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15);	$r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>();	if $r28 == null goto $r17 = new java.lang.IllegalStateException;	$r17 = new java.lang.IllegalStateException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ");	$r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25);	throw $r17
;block_num 6