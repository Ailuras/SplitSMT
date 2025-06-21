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

(declare-sort var276 0)
(declare-sort var2576 0)
(declare-sort var2706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var276 String String String) String)
(declare-fun var2706_isEmpty/-813097145 (String) Bool)
(declare-fun Float32_parseFloat/-1274905469 (String) Float32)
(declare-const null-var276 var276)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var2195 var276) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2195 null-var276)))
(declare-const var2906 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2906 null-String)))
(declare-const var3337 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3337 null-String)))
(declare-const var1930 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1930 null-String)))
(declare-const var3184 Float32) ; Statement: f1 := @parameter3: float 
(assert (not (= var3184 null-Float32)))
(assert true)
(define-const var3773 String (getServiceMethodParameter/-1810918120 var2195 var2906 var3337 var1930)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var3173 Bool (var2706_isEmpty/-813097145 var3773)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4) 
(assert (= (ite var3173 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1177 Float32 (Float32_parseFloat/-1274905469 var3773)) ; Statement: $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4) 
 ; Statement: return $f0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var2706_isEmpty/-813097145=([java.lang.String], boolean), Float32_parseFloat/-1274905469=([java.lang.String], float)}
; {var276=org.apache.dubbo.common.URL, var2195=r0, var2906=r1, var2576=null_type, var3337=r2, var1930=r3, var3184=f1, var3773=r4, var2706=org.apache.dubbo.common.utils.StringUtils, var3173=$z0, var1177=$f0}
; {org.apache.dubbo.common.URL=var276, r0=var2195, r1=var2906, null_type=var2576, r2=var3337, r3=var1930, f1=var3184, r4=var3773, org.apache.dubbo.common.utils.StringUtils=var2706, $z0=var3173, $f0=var1177}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	f1 := @parameter3: float;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4);	$f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4);	return $f0
;block_num 2