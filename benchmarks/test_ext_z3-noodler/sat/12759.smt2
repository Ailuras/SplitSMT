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

(declare-sort var2948 0)
(declare-sort var1298 0)
(declare-sort var1866 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2948 String String) String)
(declare-fun var1866_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseLong/-436876155 (String) Int)
(declare-const null-var2948 var2948)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2405 var2948) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2405 null-var2948)))
(declare-const var2462 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2462 null-String)))
(declare-const var1751 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1751 null-String)))
(declare-const var1221 Int) ; Statement: l1 := @parameter2: long 
(assert (not (= var1221 null-Int)))
(assert true)
(define-const var618 String (getServiceParameter/1782298180 var2405 var2462 var1751)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var348 Bool (var1866_isEmpty/-813097145 var618)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
(assert (= (ite var348 1 0) 0)) ; Cond: $z0 == 0 
(define-const var156 Int (Int_parseLong/-436876155 var618)) ; Statement: $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
 ; Statement: return $l0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1866_isEmpty/-813097145=([java.lang.String], boolean), Int_parseLong/-436876155=([java.lang.String], long)}
; {var2948=org.apache.dubbo.common.URL, var2405=r0, var2462=r1, var1298=null_type, var1751=r2, var1221=l1, var618=r3, var1866=org.apache.dubbo.common.utils.StringUtils, var348=$z0, var156=$l0}
; {org.apache.dubbo.common.URL=var2948, r0=var2405, r1=var2462, null_type=var1298, r2=var1751, l1=var1221, r3=var618, org.apache.dubbo.common.utils.StringUtils=var1866, $z0=var348, $l0=var156}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	l1 := @parameter2: long;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	$l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	return $l0
;block_num 2