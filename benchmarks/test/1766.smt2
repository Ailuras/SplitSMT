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

(declare-sort var500 0)
(declare-sort var510 0)
(declare-sort var43 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var500 String) String)
(declare-fun var43_isEmpty/-813097145 (String) Bool)
(declare-const null-var500 var500)
(declare-const null-String String)
(declare-const var3773 var500) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3773 null-var500)))
(declare-const var338 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var338 null-String)))
(assert true)
(define-const var1865 String (getParameter/356772413 var3773 var338)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var469 Bool (var43_isEmpty/-813097145 var1865)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (not (= (ite var469 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var43_isEmpty/-813097145=([java.lang.String], boolean)}
; {var500=org.apache.dubbo.common.Parameters, var3773=r0, var338=r1, var510=null_type, var1865=r2, var43=org.apache.dubbo.common.utils.StringUtils, var469=$z0}
; {org.apache.dubbo.common.Parameters=var500, r0=var3773, r1=var338, null_type=var510, r2=var1865, org.apache.dubbo.common.utils.StringUtils=var43, $z0=var469}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return 0
;block_num 2