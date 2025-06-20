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

(declare-sort var625 0)
(declare-sort var3092 0)
(declare-sort var894 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3092_arrayToDelimitedString/-1603437942 ((Array Int var894) String) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var894__ ((Array Int String)) (Array Int var894))
(declare-fun var3092_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var744 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var744 null-String)))
(declare-const var1349 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var1349 null-__Array__Int__String__)))
(define-const var1596 String (var3092_arrayToDelimitedString/-1603437942 (cast-from-__Array__Int__String__-to-__Array__Int__var894__ var1349) ",")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>(r0, ",") 
(define-const var3057 Bool (var3092_isEmpty/-813097145 var1596)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var3057 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1008 String var744) ; Statement: $r7 = r3 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {var3092_arrayToDelimitedString/-1603437942=([java.lang.Object[], java.lang.String], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var894__=([java.lang.String[]], java.lang.Object[]), var3092_isEmpty/-813097145=([java.lang.String], boolean)}
; {var744=r3, var625=null_type, var1349=r0, var3092=org.apache.dubbo.common.utils.StringUtils, var894=java.lang.Object, var1596=r1, var3057=$z0, var1008=$r7}
; {r3=var744, null_type=var625, r0=var1349, org.apache.dubbo.common.utils.StringUtils=var3092, java.lang.Object=var894, r1=var1596, $z0=var3057, $r7=var1008}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>(r0, ",");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r7 = r3;	goto [?= return $r7];	return $r7
;block_num 3