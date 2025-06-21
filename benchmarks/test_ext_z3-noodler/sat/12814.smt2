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

(declare-sort var298 0)
(declare-sort var2873 0)
(declare-sort var1185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var298 String String) String)
(declare-fun var1185_isEmpty/-813097145 (String) Bool)
(declare-const null-var298 var298)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2071 var298) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2071 null-var298)))
(declare-const var602 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var602 null-String)))
(declare-const var3130 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3130 null-String)))
(declare-const var15 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var15 null-Int)))
(assert true)
(define-const var3735 String (getServiceParameter/1782298180 var2071 var602 var3130)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var522 Bool (var1185_isEmpty/-813097145 var3735)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3) 
(assert (not (= (ite var522 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return b1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1185_isEmpty/-813097145=([java.lang.String], boolean)}
; {var298=org.apache.dubbo.common.URL, var2071=r0, var602=r1, var2873=null_type, var3130=r2, var15=b1, var3735=r3, var1185=org.apache.dubbo.common.utils.StringUtils, var522=$z0}
; {org.apache.dubbo.common.URL=var298, r0=var2071, r1=var602, null_type=var2873, r2=var3130, b1=var15, r3=var3735, org.apache.dubbo.common.utils.StringUtils=var1185, $z0=var522}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r3);	return b1
;block_num 2