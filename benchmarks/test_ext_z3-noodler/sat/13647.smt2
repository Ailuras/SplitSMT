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

(declare-sort var3366 0)
(declare-sort var2895 0)
(declare-sort var3275 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var3366 String String String) String)
(declare-fun var3275_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseLong/-436876155 (String) Int)
(declare-const null-var3366 var3366)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2182 var3366) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2182 null-var3366)))
(declare-const var2527 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2527 null-String)))
(declare-const var2170 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2170 null-String)))
(declare-const var3982 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3982 null-String)))
(declare-const var3466 Int) ; Statement: l1 := @parameter3: long 
(assert (not (= var3466 null-Int)))
(assert true)
(define-const var3908 String (getServiceMethodParameter/-1810918120 var2182 var2527 var2170 var3982)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var953 Bool (var3275_isEmpty/-813097145 var3908)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4) 
(assert (= (ite var953 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2920 Int (Int_parseLong/-436876155 var3908)) ; Statement: $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4) 
 ; Statement: return $l0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var3275_isEmpty/-813097145=([java.lang.String], boolean), Int_parseLong/-436876155=([java.lang.String], long)}
; {var3366=org.apache.dubbo.common.URL, var2182=r0, var2527=r1, var2895=null_type, var2170=r2, var3982=r3, var3466=l1, var3908=r4, var3275=org.apache.dubbo.common.utils.StringUtils, var953=$z0, var2920=$l0}
; {org.apache.dubbo.common.URL=var3366, r0=var2182, r1=var2527, null_type=var2895, r2=var2170, r3=var3982, l1=var3466, r4=var3908, org.apache.dubbo.common.utils.StringUtils=var3275, $z0=var953, $l0=var2920}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	l1 := @parameter3: long;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4);	$l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4);	return $l0
;block_num 2