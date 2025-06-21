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

(declare-sort var3436 0)
(declare-sort var89 0)
(declare-sort var3757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var3436 String String) String)
(declare-fun var3757_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseShort/65208931 (String) Int)
(declare-const null-var3436 var3436)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2082 var3436) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2082 null-var3436)))
(declare-const var1380 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1380 null-String)))
(declare-const var2363 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2363 null-String)))
(declare-const var502 Int) ; Statement: s1 := @parameter2: short 
(assert (not (= var502 null-Int)))
(assert true)
(define-const var196 String (getMethodParameter/2015795402 var2082 var1380 var2363)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1787 Bool (var3757_isEmpty/-813097145 var196)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
(assert (= (ite var1787 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3410 Int (Int_parseShort/65208931 var196)) ; Statement: $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
 ; Statement: return $s0 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3757_isEmpty/-813097145=([java.lang.String], boolean), Int_parseShort/65208931=([java.lang.String], short)}
; {var3436=org.apache.dubbo.common.URL, var2082=r0, var1380=r1, var89=null_type, var2363=r2, var502=s1, var196=r3, var3757=org.apache.dubbo.common.utils.StringUtils, var1787=$z0, var3410=$s0}
; {org.apache.dubbo.common.URL=var3436, r0=var2082, r1=var1380, null_type=var89, r2=var2363, s1=var502, r3=var196, org.apache.dubbo.common.utils.StringUtils=var3757, $z0=var1787, $s0=var3410}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	s1 := @parameter2: short;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	$s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	return $s0
;block_num 2