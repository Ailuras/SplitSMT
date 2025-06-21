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

(declare-sort var568 0)
(declare-sort var3768 0)
(declare-sort var947 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var947_isNotEmpty/-1514399294 ((Array Int var3768)) Bool)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3768__ ((Array Int ClassObject)) (Array Int var3768))
(declare-const null-String String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var3768 var3768)
(declare-const var48 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var48 null-String)))
(declare-const var3615 (Array Int ClassObject)) ; Statement: r5 := @parameter1: java.lang.reflect.Type[] 
(assert (not (= var3615 null-__Array__Int__ClassObject__)))
(define-const var475 String "empty") ; Statement: $r1 = "empty" 
(assert true)
(define-const var2728 Bool (= var475 var48)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "null" 
(assert (= (ite var2728 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1993 String "null") ; Statement: $r2 = "null" 
(assert true)
(define-const var1255 Bool (= var1993 var48)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z1 == 0 goto $r3 = "true" 
(assert (not (= (ite var1255 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3740 var3768 null-var3768) ; Statement: r12 = null 
 ; Statement: goto [?= $z11 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5)] 
(assert true) ; Non Conditional
(define-const var2065 Bool (var947_isNotEmpty/-1514399294 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3768__ var3615))) ; Statement: $z11 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5) 
 ; Statement: if $z11 == 0 goto return r12 
(assert (= (ite var2065 1 0) 0)) ; Cond: $z11 == 0 
 ; Statement: return r12 
(check-sat)
; {var947_isNotEmpty/-1514399294=([java.lang.Object[]], boolean), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3768__=([java.lang.reflect.Type[]], java.lang.Object[])}
; {var48=r0, var568=null_type, var3615=r5, var475=$r1, var2728=$z0, var1993=$r2, var1255=$z1, var3768=java.lang.Object, var3740=r12, var947=org.apache.dubbo.common.utils.ArrayUtils, var2065=$z11}
; {r0=var48, null_type=var568, r5=var3615, $r1=var475, $z0=var2728, $r2=var1993, $z1=var1255, java.lang.Object=var3768, r12=var3740, org.apache.dubbo.common.utils.ArrayUtils=var947, $z11=var2065}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.reflect.Type[];	$r1 = "empty";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "null";	$r2 = "null";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z1 == 0 goto $r3 = "true";	r12 = null;	goto [?= $z11 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5)];	$z11 = staticinvoke <org.apache.dubbo.common.utils.ArrayUtils: boolean isNotEmpty(java.lang.Object[])>(r5);	if $z11 == 0 goto return r12;	return r12
;block_num 5