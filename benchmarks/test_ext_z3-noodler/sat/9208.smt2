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

(declare-sort var3344 0)
(declare-sort var1119 0)
(declare-sort var3780 0)
(declare-sort var144 0)
(declare-sort var3527 0)
(declare-sort var1229 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun attributes/737601183 (var3344) var3780)
(declare-fun var3527_getAttribute/147737434 (var3780 String) var144)
(declare-fun cast-from-var144-to-String (var144) String)
(declare-fun var1229_hasText/2115555376 (String) Bool)
(declare-const null-var3344 var3344)
(declare-const null-var1119 var1119)
(declare-const var2493 var3344) ; Statement: r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator 
(assert (not (= var2493 null-var3344)))
(declare-const var2323 var1119) ; Statement: r6 := @parameter0: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var2323 null-var1119)))
(define-const var1484 var3780 (attributes/737601183 var2493)) ; Statement: $r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: java.util.Map attributes> 
(define-const var2965 var144 (var3527_getAttribute/147737434 var1484 "monitor")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>($r1, "monitor") 
(define-const var263 String (cast-from-var144-to-String var2965)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var2802 Bool (var1229_hasText/2115555376 var263)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2802 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {attributes/737601183=([org.apache.dubbo.config.spring.reference.ReferenceCreator], java.util.Map), var3527_getAttribute/147737434=([java.util.Map, java.lang.String], java.lang.Object), cast-from-var144-to-String=([java.lang.Object], java.lang.String), var1229_hasText/2115555376=([java.lang.String], boolean)}
; {var3344=org.apache.dubbo.config.spring.reference.ReferenceCreator, var2493=r0, var1119=org.apache.dubbo.config.ReferenceConfig, var2323=r6, var3780=java.util.Map, var1484=$r1, var144=java.lang.Object, var3527=org.apache.dubbo.config.spring.util.AnnotationUtils, var2965=$r2, var263=r3, var1229=org.springframework.util.StringUtils, var2802=$z0}
; {org.apache.dubbo.config.spring.reference.ReferenceCreator=var3344, r0=var2493, org.apache.dubbo.config.ReferenceConfig=var1119, r6=var2323, java.util.Map=var3780, $r1=var1484, java.lang.Object=var144, org.apache.dubbo.config.spring.util.AnnotationUtils=var3527, $r2=var2965, r3=var263, org.springframework.util.StringUtils=var1229, $z0=var2802}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator;	r6 := @parameter0: org.apache.dubbo.config.ReferenceConfig;	$r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: java.util.Map attributes>;	$r2 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>($r1, "monitor");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r3);	if $z0 == 0 goto return;	return
;block_num 2