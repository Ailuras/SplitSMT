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

(declare-sort var2662 0)
(declare-sort var2577 0)
(declare-sort var350 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2662 String String) String)
(declare-fun var350_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseLong/-436876155 (String) Int)
(declare-const null-var2662 var2662)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3956 var2662) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3956 null-var2662)))
(declare-const var2073 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2073 null-String)))
(declare-const var80 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var80 null-String)))
(declare-const var3878 Int) ; Statement: l1 := @parameter2: long 
(assert (not (= var3878 null-Int)))
(assert true)
(define-const var2703 String (getMethodParameter/2015795402 var3956 var2073 var80)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var510 Bool (var350_isEmpty/-813097145 var2703)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
(assert (= (ite var510 1 0) 0)) ; Cond: $z0 == 0 
(define-const var601 Int (Int_parseLong/-436876155 var2703)) ; Statement: $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
 ; Statement: return $l0 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var350_isEmpty/-813097145=([java.lang.String], boolean), Int_parseLong/-436876155=([java.lang.String], long)}
; {var2662=org.apache.dubbo.common.URL, var3956=r0, var2073=r1, var2577=null_type, var80=r2, var3878=l1, var2703=r3, var350=org.apache.dubbo.common.utils.StringUtils, var510=$z0, var601=$l0}
; {org.apache.dubbo.common.URL=var2662, r0=var3956, r1=var2073, null_type=var2577, r2=var80, l1=var3878, r3=var2703, org.apache.dubbo.common.utils.StringUtils=var350, $z0=var510, $l0=var601}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	l1 := @parameter2: long;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	$l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	return $l0
;block_num 2