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

(declare-sort var144 0)
(declare-sort var1447 0)
(declare-sort var2094 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var144 String) String)
(declare-fun var2094_isEmpty/-813097145 (String) Bool)
(declare-const null-var144 var144)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3210 var144) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3210 null-var144)))
(declare-const var3655 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3655 null-String)))
(declare-const var2212 Int) ; Statement: b1 := @parameter1: byte 
(assert (not (= var2212 null-Int)))
(assert true)
(define-const var2027 String (getParameter/-1307325648 var3210 var3655)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2272 Bool (var2094_isEmpty/-813097145 var2027)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2) 
(assert (not (= (ite var2272 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return b1 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2094_isEmpty/-813097145=([java.lang.String], boolean)}
; {var144=org.apache.dubbo.common.URL, var3210=r0, var3655=r1, var1447=null_type, var2212=b1, var2027=r2, var2094=org.apache.dubbo.common.utils.StringUtils, var2272=$z0}
; {org.apache.dubbo.common.URL=var144, r0=var3210, r1=var3655, null_type=var1447, b1=var2212, r2=var2027, org.apache.dubbo.common.utils.StringUtils=var2094, $z0=var2272}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	b1 := @parameter1: byte;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r2);	return b1
;block_num 2