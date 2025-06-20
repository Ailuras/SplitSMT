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

(declare-sort var2011 0)
(declare-sort var2128 0)
(declare-sort var1381 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2011 String String) String)
(declare-fun var1381_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseByte/566405473 (String) Int)
(declare-const null-var2011 var2011)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var229 var2011) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var229 null-var2011)))
(declare-const var3983 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3983 null-String)))
(declare-const var3445 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3445 null-String)))
(declare-const var1462 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var1462 null-Int)))
(assert true)
(define-const var1253 String (getServiceParameter/1782298180 var229 var3983 var3445)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2559 Bool (var1381_isEmpty/-813097145 var1253)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
(assert (= (ite var2559 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2008 Int (Int_parseByte/566405473 var1253)) ; Statement: $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
 ; Statement: return $b0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1381_isEmpty/-813097145=([java.lang.String], boolean), Int_parseByte/566405473=([java.lang.String], byte)}
; {var2011=org.apache.dubbo.common.URL, var229=r0, var3983=r1, var2128=null_type, var3445=r2, var1462=b1, var1253=r3, var1381=org.apache.dubbo.common.utils.StringUtils, var2559=$z0, var2008=$b0}
; {org.apache.dubbo.common.URL=var2011, r0=var229, r1=var3983, null_type=var2128, r2=var3445, b1=var1462, r3=var1253, org.apache.dubbo.common.utils.StringUtils=var1381, $z0=var2559, $b0=var2008}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	$b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	return $b0
;block_num 2