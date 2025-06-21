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

(declare-sort var935 0)
(declare-sort var3344 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun addConstructor/-428012916 (var3344 String) void)
(declare-const null-String String)
(declare-const null-var3344 var3344)
(declare-const var3709 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3709 null-String)))
(declare-const var144 var3344) ; Statement: r4 := @parameter1: org.apache.dubbo.common.compiler.support.CtClassBuilder 
(assert (not (= var144 null-var3344)))
(declare-const var1389 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var1389 null-String)))
(assert true)
(define-const var943 Bool (startsWith/-1785782452 var1389 var3709)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = <org.apache.dubbo.common.compiler.support.JavassistCompiler: java.util.regex.Pattern FIELD_PATTERN> 
(assert (not (= (ite var943 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2878 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2878)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2878!1 String)
(assert (= var2878!1 ""))
(assert true)
(define-const var2853 String (append/672562846 var2878!1 "public ")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("public ") 
(declare-const var2878!2 String)
(assert (= var2878!2 (str.++ var2878!1 "public ")))
(assert true)
(define-const var806 String (append/672562846 var2853 var1389)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2853!1 String)
(assert (= var2853!1 (str.++ var2853 var1389)))
(assert true)
(define-const var2338 String (toString/-2075883882 var806)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (addConstructor/-428012916 var144 var2338)) ; Statement: virtualinvoke r4.<org.apache.dubbo.common.compiler.support.CtClassBuilder: void addConstructor(java.lang.String)>($r16) 

(declare-const var144!1 var3344)
(declare-const var2338!1 String)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), addConstructor/-428012916=([org.apache.dubbo.common.compiler.support.CtClassBuilder, java.lang.String], void)}
; {var3709=r1, var935=null_type, var3344=org.apache.dubbo.common.compiler.support.CtClassBuilder, var144=r4, var1389=r0, var943=$z0, var2878=$r13, var2853=$r14, var806=$r15, var2338=$r16}
; {r1=var3709, null_type=var935, org.apache.dubbo.common.compiler.support.CtClassBuilder=var3344, r4=var144, r0=var1389, $z0=var943, $r13=var2878, $r14=var2853, $r15=var806, $r16=var2338}
;seq <java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.String;	r4 := @parameter1: org.apache.dubbo.common.compiler.support.CtClassBuilder;	r0 := @parameter2: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = <org.apache.dubbo.common.compiler.support.JavassistCompiler: java.util.regex.Pattern FIELD_PATTERN>;	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("public ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r4.<org.apache.dubbo.common.compiler.support.CtClassBuilder: void addConstructor(java.lang.String)>($r16);	goto [?= return];	return
;block_num 3