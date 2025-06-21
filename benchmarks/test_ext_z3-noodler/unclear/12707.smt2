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

(declare-sort var1858 0)
(declare-sort var3700 0)
(declare-sort var2654 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var1858 String String) String)
(declare-fun var2654_isEmpty/-813097145 (String) Bool)
(declare-fun Float32_parseFloat/-1274905469 (String) Float32)
(declare-const null-var1858 var1858)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var1779 var1858) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1779 null-var1858)))
(declare-const var1879 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1879 null-String)))
(declare-const var724 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var724 null-String)))
(declare-const var3575 Float32) ; Statement: f1 := @parameter2: float 
(assert (not (= var3575 null-Float32)))
(assert true)
(define-const var412 String (getServiceParameter/1782298180 var1779 var1879 var724)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1093 Bool (var2654_isEmpty/-813097145 var412)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
(assert (= (ite var1093 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3649 Float32 (Float32_parseFloat/-1274905469 var412)) ; Statement: $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3) 
 ; Statement: return $f0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2654_isEmpty/-813097145=([java.lang.String], boolean), Float32_parseFloat/-1274905469=([java.lang.String], float)}
; {var1858=org.apache.dubbo.common.URL, var1779=r0, var1879=r1, var3700=null_type, var724=r2, var3575=f1, var412=r3, var2654=org.apache.dubbo.common.utils.StringUtils, var1093=$z0, var3649=$f0}
; {org.apache.dubbo.common.URL=var1858, r0=var1779, r1=var1879, null_type=var3700, r2=var724, f1=var3575, r3=var412, org.apache.dubbo.common.utils.StringUtils=var2654, $z0=var1093, $f0=var3649}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	f1 := @parameter2: float;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	$f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r3);	return $f0
;block_num 2