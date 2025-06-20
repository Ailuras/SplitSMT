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

(declare-sort var3109 0)
(declare-sort var3629 0)
(declare-sort var3394 0)
(declare-sort var2014 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var3109 String String) String)
(declare-fun var3394_isEmpty/-813097145 (String) Bool)
(declare-fun var2014_parseBoolean/746105335 (String) Bool)
(declare-const null-var3109 var3109)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var293 var3109) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var293 null-var3109)))
(declare-const var881 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var881 null-String)))
(declare-const var1785 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1785 null-String)))
(declare-const var954 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var954 null-Bool)))
(assert true)
(define-const var2455 String (getMethodParameter/2015795402 var293 var881 var1785)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2810 Bool (var3394_isEmpty/-813097145 var2455)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert (= (ite var2810 1 0) 0)) ; Cond: $z0 == 0 
(define-const var362 Bool (var2014_parseBoolean/746105335 var2455)) ; Statement: $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3) 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3394_isEmpty/-813097145=([java.lang.String], boolean), var2014_parseBoolean/746105335=([java.lang.String], boolean)}
; {var3109=org.apache.dubbo.common.URL, var293=r0, var881=r1, var3629=null_type, var1785=r2, var954=z1, var2455=r3, var3394=org.apache.dubbo.common.utils.StringUtils, var2810=$z0, var2014=java.lang.Boolean, var362=$z2}
; {org.apache.dubbo.common.URL=var3109, r0=var293, r1=var881, null_type=var3629, r2=var1785, z1=var954, r3=var2455, org.apache.dubbo.common.utils.StringUtils=var3394, $z0=var2810, java.lang.Boolean=var2014, $z2=var362}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	$z2 = staticinvoke <java.lang.Boolean: boolean parseBoolean(java.lang.String)>(r3);	return $z2
;block_num 3