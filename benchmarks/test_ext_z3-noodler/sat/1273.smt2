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

(declare-sort var1714 0)
(declare-sort var648 0)
(declare-sort var3293 0)
(declare-sort var1391 0)
(declare-sort var2670 0)
(declare-sort var171 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1391_toURI/-1753049490 (String) var3293)
(declare-fun <init>/63402030 (var171 var3293 var2670) void)
(declare-fun cast-from-var1714-to-var171 (var1714) var171)
(declare-fun source/825881410 (var1714) String)
(declare-const null-var1714 var1714)
(declare-const null-String String)
(declare-const var2670-SOURCE var2670)
(declare-const var1087 var1714) ; Statement: r0 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl 
(assert (not (= var1087 null-var1714)))
(declare-const var2732 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2732 null-String)))
(declare-const var851 String) ; Statement: r8 := @parameter1: java.lang.CharSequence 
(assert (not (= var851 null-String)))
(define-const var2912 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2912)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2912!1 String)
(assert (= var2912!1 ""))
(assert true)
(define-const var1546 String (append/672562846 var2912!1 var2732)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2912!2 String)
(assert (= var2912!2 (str.++ var2912!1 var2732)))
(assert true)
(define-const var990 String (append/672562846 var1546 ".java")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java") 
(declare-const var1546!1 String)
(assert (= var1546!1 (str.++ var1546 ".java")))
(assert true)
(define-const var3375 String (toString/-2075883882 var990)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2400 var3293 (var1391_toURI/-1753049490 var3375)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.compiler.support.ClassUtils: java.net.URI toURI(java.lang.String)>($r5) 
(define-const var3349 var2670 var2670-SOURCE) ; Statement: $r6 = <javax.tools.JavaFileObject$Kind: javax.tools.JavaFileObject$Kind SOURCE> 
(assert true)
;(assert (<init>/63402030 (cast-from-var1714-to-var171 var1087) var2400 var3349)) ; Statement: specialinvoke r0.<javax.tools.SimpleJavaFileObject: void <init>(java.net.URI,javax.tools.JavaFileObject$Kind)>($r7, $r6) 

(declare-const var1087!1 var1714)
(declare-const var2400!1 var3293)
(declare-const var3349!1 var2670)
(declare-const var1087!2 var1714)
(assert (not (= var1087!2 null-var1714)))
(assert (= (source/825881410 var1087!2) var851)) ; Statement: r0.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: java.lang.CharSequence source> = r8 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1391_toURI/-1753049490=([java.lang.String], java.net.URI), <init>/63402030=([javax.tools.SimpleJavaFileObject, java.net.URI, javax.tools.JavaFileObject$Kind], void), cast-from-var1714-to-var171=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], javax.tools.SimpleJavaFileObject), source/825881410=([org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl], java.lang.CharSequence)}
; {var1714=org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl, var1087=r0, var2732=r2, var648=null_type, var851=r8, var2912=$r1, var1546=$r3, var990=$r4, var3375=$r5, var3293=java.net.URI, var1391=org.apache.dubbo.common.compiler.support.ClassUtils, var2400=$r7, var2670=javax.tools.JavaFileObject$Kind, var3349=$r6, var171=javax.tools.SimpleJavaFileObject}
; {org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl=var1714, r0=var1087, r2=var2732, null_type=var648, r8=var851, $r1=var2912, $r3=var1546, $r4=var990, $r5=var3375, java.net.URI=var3293, org.apache.dubbo.common.compiler.support.ClassUtils=var1391, $r7=var2400, javax.tools.JavaFileObject$Kind=var2670, $r6=var3349, javax.tools.SimpleJavaFileObject=var171}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl;	r2 := @parameter0: java.lang.String;	r8 := @parameter1: java.lang.CharSequence;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".java");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = staticinvoke <org.apache.dubbo.common.compiler.support.ClassUtils: java.net.URI toURI(java.lang.String)>($r5);	$r6 = <javax.tools.JavaFileObject$Kind: javax.tools.JavaFileObject$Kind SOURCE>;	specialinvoke r0.<javax.tools.SimpleJavaFileObject: void <init>(java.net.URI,javax.tools.JavaFileObject$Kind)>($r7, $r6);	r0.<org.apache.dubbo.common.compiler.support.JdkCompiler$JavaFileObjectImpl: java.lang.CharSequence source> = r8;	return
;block_num 1