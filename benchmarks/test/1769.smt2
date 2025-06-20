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

(declare-sort var694 0)
(declare-sort var244 0)
(declare-sort var2970 0)
(declare-sort var2877 0)
(declare-sort var1241 0)
(declare-sort var1055 0)
(declare-sort var966 0)
(declare-sort var546 0)
(declare-sort var2006 0)
(declare-sort var1284 0)
(declare-sort var1636 0)
(declare-sort var111 0)
(declare-sort var390 0)
(declare-sort var2541 0)
(declare-sort var3499 0)
(declare-sort var601 0)
(declare-sort var2004 0)
(declare-sort var1709 0)
(declare-sort var2321 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun var2877-init () var2877)
(declare-fun <init>/-788617071 (var2877 String String) void)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun javaFileManager/-2136503041 (var694) var1241)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun putFileForInput/372991472 (var1241 var1055 String String var966) void)
(declare-fun cast-from-var2877-to-var966 (var2877) var966)
(declare-fun compiler/-2136503041 (var694) var546)
(declare-fun diagnosticCollector/-2136503041 (var694) var2006)
(declare-fun options/-2136503041 (var694) var1284)
(declare-fun var1636_singletonList/684126186 (var111) var1284)
(declare-fun cast-from-var2877-to-var111 (var2877) var111)
(declare-fun var546_getTask/763094539 (var546 var2541 var3499 var601 var2004 var2004 var2004) var390)
(declare-fun cast-from-var1241-to-var3499 (var1241) var3499)
(declare-fun cast-from-var2006-to-var601 (var2006) var601)
(declare-fun cast-from-var1284-to-var2004 (var1284) var2004)
(declare-fun var390_call/-916517215 (var390) var1709)
(declare-fun var2321-init () var2321)
(declare-fun getDiagnostics/-246447062 (var2006) var1284)
(declare-fun append/-1031950772 (String var111) String)
(declare-fun cast-from-var1284-to-var111 (var1284) var111)
(declare-fun <init>/-1092629202 (var2321 String) void)
(declare-const null-var694 var694)
(declare-const null-var244 var244)
(declare-const null-String String)
(declare-const var1055-SOURCE_PATH var1055)
(declare-const null-var2541 var2541)
(declare-const null-var2004 var2004)
(declare-const null-var1709 var1709)
(declare-const var1459 var694) ; Statement: r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler 
(assert (not (= var1459 null-var694)))
(declare-const var2756 var244) ; Statement: r29 := @parameter0: java.lang.ClassLoader 
(assert (not (= var2756 null-var244)))
(declare-const var1901 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1901 null-String)))
(declare-const var2554 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2554 null-String)))
(assert true)
(define-const var532 Int (lastIndexOf/-1292097097 var1901 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46) 
 ; Statement: if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(assert (not (>= var532 0))) ; Negate: Cond: i0 >= 0  
(define-const var3370 String "") ; Statement: $r30 = "" 
 ; Statement: goto [?= r1 = $r30] 
(assert true) ; Non Conditional
(define-const var1589 String var3370) ; Statement: r1 = $r30 
 ; Statement: if i0 >= 0 goto $i1 = i0 + 1 
(assert (>= var532 0)) ; Cond: i0 >= 0 
(define-const var1192 Int (+ var532 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var1192 0) (>= (str.len var1901) var1192))))
(define-const var1812 String (substring/850833817 var1901 var1192)) ; Statement: $r31 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(assert true) ; Non Conditional
(define-const var294 var2877 var2877-init) ; Statement: $r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl 
(assert true)
;(assert (<init>/-788617071 var294 var1812 (cast-from-String-to-String var2554))) ; Statement: specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3) 

(declare-const var294!1 var2877)
(declare-const var1812!1 String)
(declare-const var2554!1 String)
(define-const var2290 var1241 (javaFileManager/-2136503041 var1459)) ; Statement: $r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var270 var1055 var1055-SOURCE_PATH) ; Statement: $r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH> 
(define-const var2913 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2913)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2913!1 String)
(assert (= var2913!1 ""))
(assert true)
(define-const var2556 String (append/672562846 var2913!1 var1812!1)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31) 
(declare-const var2913!2 String)
(assert (= var2913!2 (str.++ var2913!1 var1812!1)))
(assert true)
(define-const var3477 String (append/672562846 var2556 ".java")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java") 
(declare-const var2556!1 String)
(assert (= var2556!1 (str.++ var2556 ".java")))
(assert true)
(define-const var2888 String (toString/-2075883882 var3477)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (putFileForInput/372991472 var2290 var270 var1589 var2888 (cast-from-var2877-to-var966 var294!1))) ; Statement: virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2) 

(declare-const var2290!1 var1241)
(declare-const var270!1 var1055)
(declare-const var1589!1 String)
(declare-const var2888!1 String)
(declare-const var294!2 var2877)
(define-const var3105 var546 (compiler/-2136503041 var1459)) ; Statement: $r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler> 
(define-const var1809 var1241 (javaFileManager/-2136503041 var1459)) ; Statement: $r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager> 
(define-const var1051 var2006 (diagnosticCollector/-2136503041 var1459)) ; Statement: $r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(define-const var928 var1284 (options/-2136503041 var1459)) ; Statement: $r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options> 
(define-const var3457 var1284 (var1636_singletonList/684126186 (cast-from-var2877-to-var111 var294!2))) ; Statement: $r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2) 
(define-const var2537 var390 (var546_getTask/763094539 var3105 null-var2541 (cast-from-var1241-to-var3499 var1809) (cast-from-var2006-to-var601 var1051) (cast-from-var1284-to-var2004 var928) null-var2004 (cast-from-var1284-to-var2004 var3457))) ; Statement: $r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15) 
(define-const var2539 var1709 (var390_call/-916517215 var2537)) ; Statement: $r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>() 
 ; Statement: if $r28 == null goto $r17 = new java.lang.IllegalStateException 
(assert (= var2539 null-var1709)) ; Cond: $r28 == null 
(define-const var3440 var2321 var2321-init) ; Statement: $r17 = new java.lang.IllegalStateException 
(define-const var2739 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2739)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2739!1 String)
(assert (= var2739!1 ""))
(assert true)
(define-const var3812 String (append/672562846 var2739!1 "Compilation failed. class: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ") 
(declare-const var2739!2 String)
(assert (= var2739!2 (str.++ var2739!1 "Compilation failed. class: ")))
(assert true)
(define-const var1376 String (append/672562846 var3812 var1901)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3812!1 String)
(assert (= var3812!1 (str.++ var3812 var1901)))
(assert true)
(define-const var3651 String (append/672562846 var1376 ", diagnostics: ")) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ") 
(declare-const var1376!1 String)
(assert (= var1376!1 (str.++ var1376 ", diagnostics: ")))
(define-const var1469 var2006 (diagnosticCollector/-2136503041 var1459)) ; Statement: $r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector> 
(assert true)
(define-const var2210 var1284 (getDiagnostics/-246447062 var1469)) ; Statement: $r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>() 
(assert true)
(define-const var1257 String (append/-1031950772 var3651 (cast-from-var1284-to-var111 var2210))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22) 
(declare-const var3651!1 String)
(assert (str.prefixof var3651 var3651!1))
(assert true)
(define-const var3113 String (toString/-2075883882 var1257)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3440 var3113)) ; Statement: specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25) 

(declare-const var3440!1 var2321)
(declare-const var3113!1 String)
 ; Statement: throw $r17 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), substring/850833817=([java.lang.String, int], java.lang.String), var2877-init=([], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl), <init>/-788617071=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, java.lang.String, java.lang.CharSequence], void), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), javaFileManager/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), putFileForInput/372991472=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, javax.tools.StandardLocation, java.lang.String, java.lang.String, javax.tools.JavaFileObject], void), cast-from-var2877-to-var966=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], javax.tools.JavaFileObject), compiler/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.JavaCompiler), diagnosticCollector/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], javax.tools.DiagnosticCollector), options/-2136503041=([org.apache.dubbo.common.compiler.support.JdkCompiler], java.util.List), var1636_singletonList/684126186=([java.lang.Object], java.util.List), cast-from-var2877-to-var111=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], java.lang.Object), var546_getTask/763094539=([javax.tools.JavaCompiler, java.io.Writer, javax.tools.JavaFileManager, javax.tools.DiagnosticListener, java.lang.Iterable, java.lang.Iterable, java.lang.Iterable], javax.tools.JavaCompiler$CompilationTask), cast-from-var1241-to-var3499=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl], javax.tools.JavaFileManager), cast-from-var2006-to-var601=([javax.tools.DiagnosticCollector], javax.tools.DiagnosticListener), cast-from-var1284-to-var2004=([java.util.List], java.lang.Iterable), var390_call/-916517215=([javax.tools.JavaCompiler$CompilationTask], java.lang.Boolean), var2321-init=([], java.lang.IllegalStateException), getDiagnostics/-246447062=([javax.tools.DiagnosticCollector], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1284-to-var111=([java.util.List], java.lang.Object), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var694=org.apache.dubbo.common.compiler.support.JdkCompiler, var1459=r4, var244=java.lang.ClassLoader, var2756=r29, var1901=r0, var2970=null_type, var2554=r3, var532=i0, var3370=$r30, var1589=r1, var1192=$i1, var1812=$r31, var2877=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, var294=$r2, var1241=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl, var2290=$r6, var1055=javax.tools.StandardLocation, var270=$r7, var2913=$r5, var2556=$r8, var3477=$r9, var2888=$r10, var966=javax.tools.JavaFileObject, var546=javax.tools.JavaCompiler, var3105=$r11, var1809=$r12, var2006=javax.tools.DiagnosticCollector, var1051=$r13, var1284=java.util.List, var928=$r14, var1636=java.util.Collections, var111=java.lang.Object, var3457=$r15, var390=javax.tools.JavaCompiler$CompilationTask, var2541=java.io.Writer, var3499=javax.tools.JavaFileManager, var601=javax.tools.DiagnosticListener, var2004=java.lang.Iterable, var2537=$r16, var1709=java.lang.Boolean, var2539=$r28, var2321=java.lang.IllegalStateException, var3440=$r17, var2739=$r18, var3812=$r19, var1376=$r20, var3651=$r23, var1469=$r21, var2210=$r22, var1257=$r24, var3113=$r25}
; {org.apache.dubbo.common.compiler.support.JdkCompiler=var694, r4=var1459, java.lang.ClassLoader=var244, r29=var2756, r0=var1901, null_type=var2970, r3=var2554, i0=var532, $r30=var3370, r1=var1589, $i1=var1192, $r31=var1812, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl=var2877, $r2=var294, org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl=var1241, $r6=var2290, javax.tools.StandardLocation=var1055, $r7=var270, $r5=var2913, $r8=var2556, $r9=var3477, $r10=var2888, javax.tools.JavaFileObject=var966, javax.tools.JavaCompiler=var546, $r11=var3105, $r12=var1809, javax.tools.DiagnosticCollector=var2006, $r13=var1051, java.util.List=var1284, $r14=var928, java.util.Collections=var1636, java.lang.Object=var111, $r15=var3457, javax.tools.JavaCompiler$CompilationTask=var390, java.io.Writer=var2541, javax.tools.JavaFileManager=var3499, javax.tools.DiagnosticListener=var601, java.lang.Iterable=var2004, $r16=var2537, java.lang.Boolean=var1709, $r28=var2539, java.lang.IllegalStateException=var2321, $r17=var3440, $r18=var2739, $r19=var3812, $r20=var1376, $r23=var3651, $r21=var1469, $r22=var2210, $r24=var1257, $r25=var3113}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler;	r29 := @parameter0: java.lang.ClassLoader;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46);	if i0 >= 0 goto $r30 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r30 = "";	goto [?= r1 = $r30];	r1 = $r30;	if i0 >= 0 goto $i1 = i0 + 1;	$i1 = i0 + 1;	$r31 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	$r2 = new org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl;	specialinvoke $r2.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: void <init>(java.lang.String,java.lang.CharSequence)>($r31, r3);	$r6 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r7 = <javax.tools.StandardLocation: javax.tools.StandardLocation SOURCE_PATH>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r31);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r6.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl: void putFileForInput(javax.tools.StandardLocation,java.lang.String,java.lang.String,javax.tools.JavaFileObject)>($r7, r1, $r10, $r2);	$r11 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.JavaCompiler compiler>;	$r12 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileManagerImpl javaFileManager>;	$r13 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r14 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: java.util.List options>;	$r15 = staticinvoke <java.util.Collections: java.util.List singletonList(java.lang.Object)>($r2);	$r16 = interfaceinvoke $r11.<javax.tools.JavaCompiler: javax.tools.JavaCompiler$CompilationTask getTask(java.io.Writer,javax.tools.JavaFileManager,javax.tools.DiagnosticListener,java.lang.Iterable,java.lang.Iterable,java.lang.Iterable)>(null, $r12, $r13, $r14, null, $r15);	$r28 = interfaceinvoke $r16.<javax.tools.JavaCompiler$CompilationTask: java.lang.Boolean call()>();	if $r28 == null goto $r17 = new java.lang.IllegalStateException;	$r17 = new java.lang.IllegalStateException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Compilation failed. class: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", diagnostics: ");	$r21 = r4.<org.apache.dubbo.common.compiler.support.JdkCompiler: javax.tools.DiagnosticCollector diagnosticCollector>;	$r22 = virtualinvoke $r21.<javax.tools.DiagnosticCollector: java.util.List getDiagnostics()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r25);	throw $r17
;block_num 6