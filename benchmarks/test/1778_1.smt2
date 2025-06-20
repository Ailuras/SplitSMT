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

(declare-sort var1718 0)
(declare-sort var2329 0)
(declare-sort var2805 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var1718 String) String)
(declare-fun var2805_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var1718 var1718)
(declare-const null-String String)
(declare-const var3461 var1718) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3461 null-var1718)))
(declare-const var813 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var813 null-String)))
(assert true)
(define-const var2203 String (getParameter/356772413 var3461 var813)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var537 Bool (var2805_isEmpty/-813097145 var2203)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (= (ite var537 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3786 Int (Int_parseInt/1370970945 var2203)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
 ; Statement: return $i0 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var2805_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var1718=org.apache.dubbo.common.Parameters, var3461=r0, var813=r1, var2329=null_type, var2203=r2, var2805=org.apache.dubbo.common.utils.StringUtils, var537=$z0, var3786=$i0}
; {org.apache.dubbo.common.Parameters=var1718, r0=var3461, r1=var813, null_type=var2329, r2=var2203, org.apache.dubbo.common.utils.StringUtils=var2805, $z0=var537, $i0=var3786}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return $i0
;block_num 2