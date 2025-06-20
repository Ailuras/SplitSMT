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

(declare-sort var101 0)
(declare-sort var749 0)
(declare-sort var3555 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var101 String String String) String)
(declare-fun var3555_isEmpty/-813097145 (String) Bool)
(declare-const null-var101 var101)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var689 var101) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var689 null-var101)))
(declare-const var2322 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2322 null-String)))
(declare-const var3532 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3532 null-String)))
(declare-const var161 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var161 null-String)))
(declare-const var2880 Float32) ; Statement: f1 := @parameter3: float 
(assert (not (= var2880 null-Float32)))
(assert true)
(define-const var3328 String (getServiceMethodParameter/-1810918120 var689 var2322 var3532 var161)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var372 Bool (var3555_isEmpty/-813097145 var3328)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4) 
(assert (not (= (ite var372 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return f1 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var3555_isEmpty/-813097145=([java.lang.String], boolean)}
; {var101=org.apache.dubbo.common.URL, var689=r0, var2322=r1, var749=null_type, var3532=r2, var161=r3, var2880=f1, var3328=r4, var3555=org.apache.dubbo.common.utils.StringUtils, var372=$z0}
; {org.apache.dubbo.common.URL=var101, r0=var689, r1=var2322, null_type=var749, r2=var3532, r3=var161, f1=var2880, r4=var3328, org.apache.dubbo.common.utils.StringUtils=var3555, $z0=var372}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	f1 := @parameter3: float;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $f0 = staticinvoke <java.lang.Float: float parseFloat(java.lang.String)>(r4);	return f1
;block_num 2