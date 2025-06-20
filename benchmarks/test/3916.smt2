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

(declare-sort var1272 0)
(declare-sort var3036 0)
(declare-sort var3970 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getAddress/-2093578336 (var1272) String)
(declare-fun var1272_appendDefaultPort/952404028 (String Int) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getParameter/1812918763 (var1272 String (Array Int String)) (Array Int String))
(declare-fun var3036_isNotEmpty/-1514399294 ((Array Int var3970)) Bool)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3970__ ((Array Int String)) (Array Int var3970))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1272 var1272)
(declare-const null-Int Int)
(declare-const var2596 var1272) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2596 null-var1272)))
(declare-const var1849 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1849 null-Int)))
(define-const var3649 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var1670 String (getAddress/-2093578336 var2596)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(define-const var95 String (var1272_appendDefaultPort/952404028 var1670 var1849)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String appendDefaultPort(java.lang.String,int)>($r2, i0) 
(assert true)
;(assert (<init>/-1061048412 var3649 var95)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r3) 
(declare-const var3649!1 String)
(assert (= var3649!1 var95))
(define-const var466 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[0] 
(assert true)
(define-const var3571 (Array Int String) (getParameter/1812918763 var2596 "backup" var466)) ; Statement: r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String[] getParameter(java.lang.String,java.lang.String[])>("backup", $r4) 
(define-const var2748 Bool (var3036_isNotEmpty/-1514399294 (cast-from-__Array__Int__String__-to-__Array__Int__var3970__ var3571))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5) 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2748 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2395 String (toString/-2075883882 var3649!1)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), var1272_appendDefaultPort/952404028=([java.lang.String, int], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), arr-String-init=([], java.lang.String[]), getParameter/1812918763=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String[]], java.lang.String[]), var3036_isNotEmpty/-1514399294=([java.lang.Object[]], boolean), cast-from-__Array__Int__String__-to-__Array__Int__var3970__=([java.lang.String[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1272=org.apache.dubbo.common.URL, var2596=r1, var1849=i0, var3649=$r0, var1670=$r2, var95=$r3, var466=$r4, var3571=r5, var3036=org.apache.dubbo.common.utils.ArrayUtils, var3970=java.lang.Object, var2748=$z0, var2395=$r6}
; {org.apache.dubbo.common.URL=var1272, r1=var2596, i0=var1849, $r0=var3649, $r2=var1670, $r3=var95, $r4=var466, r5=var3571, org.apache.dubbo.common.utils.ArrayUtils=var3036, java.lang.Object=var3970, $z0=var2748, $r6=var2395}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	i0 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String appendDefaultPort(java.lang.String,int)>($r2, i0);	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r3);	$r4 = newarray (java.lang.String)[0];	r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String[] getParameter(java.lang.String,java.lang.String[])>("backup", $r4);	$z0 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5);	if $z0 == 0 goto $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 2