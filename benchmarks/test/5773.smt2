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

(declare-sort var1517 0)
(declare-sort var1150 0)
(declare-sort var1050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1517 String) String)
(declare-fun var1050_isEmpty/-813097145 (String) Bool)
(declare-const null-var1517 var1517)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var672 var1517) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var672 null-var1517)))
(declare-const var3489 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3489 null-String)))
(declare-const var125 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var125 null-Int)))
(assert true)
(define-const var3270 String (getParameter/-1307325648 var672 var3489)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1920 Bool (var1050_isEmpty/-813097145 var3270)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2) 
(assert (not (= (ite var1920 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return l1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var1050_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1517=org.apache.dubbo.common.URL, var672=r0, var3489=r1, var1150=null_type, var125=l1, var3270=r2, var1050=org.apache.dubbo.common.utils.StringUtils, var1920=$z0}
; {org.apache.dubbo.common.URL=var1517, r0=var672, r1=var3489, null_type=var1150, l1=var125, r2=var3270, org.apache.dubbo.common.utils.StringUtils=var1050, $z0=var1920}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	l1 := @parameter1: long;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r2);	return l1
;block_num 2