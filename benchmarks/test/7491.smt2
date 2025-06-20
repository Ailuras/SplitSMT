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

(declare-sort var1889 0)
(declare-sort var3206 0)
(declare-sort var1708 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1708_isEmpty/-813097145 (String) Bool)
(declare-fun var1889_encode/1794151917 (String) String)
(declare-fun addParameter/-1629709269 (var1889 String String) var1889)
(declare-const null-var1889 var1889)
(declare-const null-String String)
(declare-const var2098 var1889) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2098 null-var1889)))
(declare-const var2753 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2753 null-String)))
(declare-const var2908 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2908 null-String)))
(define-const var2454 Bool (var1708_isEmpty/-813097145 var2908)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (= (ite var2454 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1321 String (var1889_encode/1794151917 var2908)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert true)
(define-const var1968 var1889 (addParameter/-1629709269 var2098 var2753 var1321)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {var1708_isEmpty/-813097145=([java.lang.String], boolean), var1889_encode/1794151917=([java.lang.String], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var1889=org.apache.dubbo.common.URL, var2098=r1, var2753=r2, var3206=null_type, var2908=r0, var1708=org.apache.dubbo.common.utils.StringUtils, var2454=$z0, var1321=$r3, var1968=$r4}
; {org.apache.dubbo.common.URL=var1889, r1=var2098, r2=var2753, null_type=var3206, r0=var2908, org.apache.dubbo.common.utils.StringUtils=var1708, $z0=var2454, $r3=var1321, $r4=var1968}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2