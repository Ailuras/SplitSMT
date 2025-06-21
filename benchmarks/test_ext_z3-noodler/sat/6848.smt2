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

(declare-sort var1279 0)
(declare-sort var824 0)
(declare-sort var3982 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var1279 String String) String)
(declare-fun var3982_isEmpty/-813097145 (String) Bool)
(declare-const null-var1279 var1279)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3105 var1279) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3105 null-var1279)))
(declare-const var2062 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2062 null-String)))
(declare-const var3669 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3669 null-String)))
(declare-const var2886 Int) ; Statement: s1 := @parameter2: short 
(assert (not (= var2886 null-Int)))
(assert true)
(define-const var2792 String (getMethodParameter/2015795402 var3105 var2062 var3669)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2206 Bool (var3982_isEmpty/-813097145 var2792)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
(assert (not (= (ite var2206 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return s1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3982_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1279=org.apache.dubbo.common.URL, var3105=r0, var2062=r1, var824=null_type, var3669=r2, var2886=s1, var2792=r3, var3982=org.apache.dubbo.common.utils.StringUtils, var2206=$z0}
; {org.apache.dubbo.common.URL=var1279, r0=var3105, r1=var2062, null_type=var824, r2=var3669, s1=var2886, r3=var2792, org.apache.dubbo.common.utils.StringUtils=var3982, $z0=var2206}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	s1 := @parameter2: short;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	return s1
;block_num 2