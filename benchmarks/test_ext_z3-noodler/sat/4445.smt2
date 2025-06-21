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

(declare-sort var525 0)
(declare-sort var2737 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var2737_isAnyEmpty/296893969 ((Array Int String)) Bool)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1659 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1659 null-String)))
(declare-const var3414 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3414 null-String)))
(define-const var3628 (Array Int String) arr-String-init) ; Statement: $r0 = newarray (java.lang.String)[2] 
(declare-const var3628!1 (Array Int String))
(assert (not (= var3628!1 null-__Array__Int__String__)))
(assert (= (select var3628!1 0) var1659)) ; Statement: $r0[0] = r1 
(declare-const var3628!2 (Array Int String))
(assert (not (= var3628!2 null-__Array__Int__String__)))
(assert (= (select var3628!2 1) var3414)) ; Statement: $r0[1] = r2 
(define-const var1 Bool (var2737_isAnyEmpty/296893969 var3628!2)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r0) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>(r2) 
(assert (not (= (ite var1 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {arr-String-init=([], java.lang.String[]), var2737_isAnyEmpty/296893969=([java.lang.String[]], boolean)}
; {var1659=r1, var525=null_type, var3414=r2, var3628=$r0, var2737=org.apache.dubbo.common.utils.StringUtils, var1=$z0}
; {r1=var1659, null_type=var525, r2=var3414, $r0=var3628, org.apache.dubbo.common.utils.StringUtils=var2737, $z0=var1}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>": 1}
;stmts r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r0 = newarray (java.lang.String)[2];	$r0[0] = r1;	$r0[1] = r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isAnyEmpty(java.lang.String[])>($r0);	if $z0 == 0 goto $z1 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>(r2);	return r1
;block_num 2