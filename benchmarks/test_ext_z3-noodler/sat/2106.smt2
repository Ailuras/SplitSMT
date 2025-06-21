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

(declare-sort var3184 0)
(declare-sort var1420 0)
(declare-sort var2643 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3184 String String) String)
(declare-fun var2643_isEmpty/-813097145 (String) Bool)
(declare-const null-var3184 var3184)
(declare-const null-String String)
(declare-const var2462 var3184) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2462 null-var3184)))
(declare-const var2597 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2597 null-String)))
(declare-const var179 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var179 null-String)))
(assert true)
(define-const var1263 String (getMethodParameter/2069355293 var2462 var2597 var179)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3305 Bool (var2643_isEmpty/-813097145 var1263)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
(assert (not (= (ite var3305 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var2643_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3184=org.apache.dubbo.common.Parameters, var2462=r0, var2597=r1, var1420=null_type, var179=r2, var1263=r3, var2643=org.apache.dubbo.common.utils.StringUtils, var3305=$z0}
; {org.apache.dubbo.common.Parameters=var3184, r0=var2462, r1=var2597, null_type=var1420, r2=var179, r3=var1263, org.apache.dubbo.common.utils.StringUtils=var2643, $z0=var3305}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	return 0
;block_num 2