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

(declare-sort var2571 0)
(declare-sort var2202 0)
(declare-sort var926 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var2571 String String) String)
(declare-fun var926_isEmpty/-813097145 (String) Bool)
(declare-const null-var2571 var2571)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3681 var2571) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3681 null-var2571)))
(declare-const var3262 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3262 null-String)))
(declare-const var1662 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1662 null-String)))
(declare-const var1180 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var1180 null-Int)))
(assert true)
(define-const var3209 String (getMethodParameter/2015795402 var3681 var3262 var1662)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3668 Bool (var926_isEmpty/-813097145 var3209)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
(assert (not (= (ite var3668 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return b1 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var926_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2571=org.apache.dubbo.common.URL, var3681=r0, var3262=r1, var2202=null_type, var1662=r2, var1180=b1, var3209=r3, var926=org.apache.dubbo.common.utils.StringUtils, var3668=$z0}
; {org.apache.dubbo.common.URL=var2571, r0=var3681, r1=var3262, null_type=var2202, r2=var1662, b1=var1180, r3=var3209, org.apache.dubbo.common.utils.StringUtils=var926, $z0=var3668}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	return b1
;block_num 2