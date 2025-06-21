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

(declare-sort var995 0)
(declare-sort var3541 0)
(declare-sort var3680 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var995 String) String)
(declare-fun var3680_isEmpty/-813097145 (String) Bool)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-const null-var995 var995)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2948 var995) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2948 null-var995)))
(declare-const var3957 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3957 null-String)))
(declare-const var550 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var550 null-Int)))
(assert true)
(define-const var697 String (getParameter/-1307325648 var2948 var3957)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2479 Bool (var3680_isEmpty/-813097145 var697)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0) 
(assert (= (ite var2479 1 0) 0)) ; Cond: $z0 == 0 
(assert (and true (and (> (str.len var697) 0) (<= 0 0))))
(define-const var2350 Int (charAt/698050440 var697 0)) ; Statement: $c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0) 
(assert true) ; Non Conditional
 ; Statement: return $c1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3680_isEmpty/-813097145=([java.lang.String], boolean), charAt/698050440=([java.lang.String, int], char)}
; {var995=org.apache.dubbo.common.URL, var2948=r0, var3957=r1, var3541=null_type, var550=c0, var697=r2, var3680=org.apache.dubbo.common.utils.StringUtils, var2479=$z0, var2350=$c1}
; {org.apache.dubbo.common.URL=var995, r0=var2948, r1=var3957, null_type=var3541, c0=var550, r2=var697, org.apache.dubbo.common.utils.StringUtils=var3680, $z0=var2479, $c1=var2350}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: char charAt(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	c0 := @parameter1: char;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0);	$c1 = virtualinvoke r2.<java.lang.String: char charAt(int)>(0);	return $c1
;block_num 3