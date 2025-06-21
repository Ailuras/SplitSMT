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

(declare-sort var1190 0)
(declare-sort var1751 0)
(declare-sort var170 0)
(declare-sort var508 0)
(declare-sort var835 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCachedNumber/854871038 (var1190 String String) var170)
(declare-fun getMethodParameter/2015795402 (var508 String String) String)
(declare-fun cast-from-var1190-to-var508 (var1190) var508)
(declare-fun var835_isEmpty/-813097145 (String) Bool)
(declare-const null-var1190 var1190)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var170 var170)
(declare-const var2352 var1190) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (not (= var2352 null-var1190)))
(declare-const var3529 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3529 null-String)))
(declare-const var868 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var868 null-String)))
(declare-const var3175 Int) ; Statement: b1 := @parameter2: byte 
(assert (not (= var3175 null-Int)))
(assert true)
(define-const var3170 var170 (getCachedNumber/854871038 var2352 var3529 var868)) ; Statement: r3 = specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.Number getCachedNumber(java.lang.String,java.lang.String)>(r1, r2) 
 ; Statement: if r3 == null goto r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(assert (= var3170 null-var170)) ; Cond: r3 == null 
(assert true)
(define-const var2518 String (getMethodParameter/2015795402 (cast-from-var1190-to-var508 var2352) var3529 var868)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var947 Bool (var835_isEmpty/-813097145 var2518)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4) 
(assert (not (= (ite var947 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return b1 
(check-sat)
; {getCachedNumber/854871038=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String], java.lang.Number), getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var1190-to-var508=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var835_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1190=org.apache.dubbo.common.url.component.ServiceConfigURL, var2352=r0, var3529=r1, var1751=null_type, var868=r2, var3175=b1, var170=java.lang.Number, var3170=r3, var508=org.apache.dubbo.common.URL, var2518=r4, var835=org.apache.dubbo.common.utils.StringUtils, var947=$z0}
; {org.apache.dubbo.common.url.component.ServiceConfigURL=var1190, r0=var2352, r1=var3529, null_type=var1751, r2=var868, b1=var3175, java.lang.Number=var170, r3=var3170, org.apache.dubbo.common.URL=var508, r4=var2518, org.apache.dubbo.common.utils.StringUtils=var835, $z0=var947}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	b1 := @parameter2: byte;	r3 = specialinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.Number getCachedNumber(java.lang.String,java.lang.String)>(r1, r2);	if r3 == null goto r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	r4 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto b0 = staticinvoke <java.lang.Byte: byte parseByte(java.lang.String)>(r4);	return b1
;block_num 3