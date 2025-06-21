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

(declare-sort var1558 0)
(declare-sort var1797 0)
(declare-sort var3241 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var1558 String String String) String)
(declare-fun var3241_isEmpty/-813097145 (String) Bool)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var1558 var1558)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var359 var1558) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var359 null-var1558)))
(declare-const var2454 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2454 null-String)))
(declare-const var1089 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1089 null-String)))
(declare-const var2757 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2757 null-String)))
(declare-const var2122 Float64) ; Statement: d1 := @parameter3: double 
(assert (not (= var2122 null-Float64)))
(assert true)
(define-const var2954 String (getServiceMethodParameter/-1810918120 var359 var2454 var1089 var2757)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var3348 Bool (var3241_isEmpty/-813097145 var2954)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r4) 
(assert (= (ite var3348 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3185 Float64 (Float64_parseDouble/1471110886 var2954)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r4) 
 ; Statement: return $d0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var3241_isEmpty/-813097145=([java.lang.String], boolean), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var1558=org.apache.dubbo.common.URL, var359=r0, var2454=r1, var1797=null_type, var1089=r2, var2757=r3, var2122=d1, var2954=r4, var3241=org.apache.dubbo.common.utils.StringUtils, var3348=$z0, var3185=$d0}
; {org.apache.dubbo.common.URL=var1558, r0=var359, r1=var2454, null_type=var1797, r2=var1089, r3=var2757, d1=var2122, r4=var2954, org.apache.dubbo.common.utils.StringUtils=var3241, $z0=var3348, $d0=var3185}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	d1 := @parameter3: double;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r4);	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r4);	return $d0
;block_num 2