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

(declare-sort var3848 0)
(declare-sort var3750 0)
(declare-sort var2287 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3848 String) String)
(declare-fun var2287_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseLong/-436876155 (String) Int)
(declare-const null-var3848 var3848)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2761 var3848) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2761 null-var3848)))
(declare-const var323 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var323 null-String)))
(declare-const var3223 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var3223 null-Int)))
(assert true)
(define-const var781 String (getParameter/-1307325648 var2761 var323)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3798 Bool (var2287_isEmpty/-813097145 var781)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2) 
(assert (= (ite var3798 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2127 Int (Int_parseLong/-436876155 var781)) ; Statement: $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2) 
 ; Statement: return $l0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2287_isEmpty/-813097145=([java.lang.String], boolean), Int_parseLong/-436876155=([java.lang.String], long)}
; {var3848=org.apache.dubbo.common.URL, var2761=r0, var323=r1, var3750=null_type, var3223=l1, var781=r2, var2287=org.apache.dubbo.common.utils.StringUtils, var3798=$z0, var2127=$l0}
; {org.apache.dubbo.common.URL=var3848, r0=var2761, r1=var323, null_type=var3750, l1=var3223, r2=var781, org.apache.dubbo.common.utils.StringUtils=var2287, $z0=var3798, $l0=var2127}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	l1 := @parameter1: long;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2);	$l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2);	return $l0
;block_num 2