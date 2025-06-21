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

(declare-sort var1088 0)
(declare-sort var2012 0)
(declare-sort var2672 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var1088 String String String) String)
(declare-fun var2672_isEmpty/-813097145 (String) Bool)
(declare-const null-var1088 var1088)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var838 var1088) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var838 null-var1088)))
(declare-const var3785 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3785 null-String)))
(declare-const var1247 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1247 null-String)))
(declare-const var385 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var385 null-String)))
(declare-const var961 Int) ; Statement: l1 := @parameter3: long 
(assert (not (= var961 null-Int)))
(assert true)
(define-const var1366 String (getServiceMethodParameter/-1810918120 var838 var3785 var1247 var385)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var2382 Bool (var2672_isEmpty/-813097145 var1366)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4) 
(assert (not (= (ite var2382 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return l1 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var2672_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1088=org.apache.dubbo.common.URL, var838=r0, var3785=r1, var2012=null_type, var1247=r2, var385=r3, var961=l1, var1366=r4, var2672=org.apache.dubbo.common.utils.StringUtils, var2382=$z0}
; {org.apache.dubbo.common.URL=var1088, r0=var838, r1=var3785, null_type=var2012, r2=var1247, r3=var385, l1=var961, r4=var1366, org.apache.dubbo.common.utils.StringUtils=var2672, $z0=var2382}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	l1 := @parameter3: long;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r4);	return l1
;block_num 2