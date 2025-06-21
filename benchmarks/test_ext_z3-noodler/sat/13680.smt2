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

(declare-sort var96 0)
(declare-sort var643 0)
(declare-sort var2183 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var96 String String String) String)
(declare-fun var2183_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseShort/65208931 (String) Int)
(declare-const null-var96 var96)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var208 var96) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var208 null-var96)))
(declare-const var1799 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1799 null-String)))
(declare-const var1060 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1060 null-String)))
(declare-const var1971 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1971 null-String)))
(declare-const var1996 Int) ; Statement: s1 := @parameter3: short 
(assert (not (= var1996 null-Int)))
(assert true)
(define-const var1542 String (getServiceMethodParameter/-1810918120 var208 var1799 var1060 var1971)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var3379 Bool (var2183_isEmpty/-813097145 var1542)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r4) 
(assert (= (ite var3379 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3912 Int (Int_parseShort/65208931 var1542)) ; Statement: $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r4) 
 ; Statement: return $s0 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var2183_isEmpty/-813097145=([java.lang.String], boolean), Int_parseShort/65208931=([java.lang.String], short)}
; {var96=org.apache.dubbo.common.URL, var208=r0, var1799=r1, var643=null_type, var1060=r2, var1971=r3, var1996=s1, var1542=r4, var2183=org.apache.dubbo.common.utils.StringUtils, var3379=$z0, var3912=$s0}
; {org.apache.dubbo.common.URL=var96, r0=var208, r1=var1799, null_type=var643, r2=var1060, r3=var1971, s1=var1996, r4=var1542, org.apache.dubbo.common.utils.StringUtils=var2183, $z0=var3379, $s0=var3912}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	s1 := @parameter3: short;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r4);	$s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r4);	return $s0
;block_num 2