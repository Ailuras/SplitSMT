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

(declare-sort var2168 0)
(declare-sort var3833 0)
(declare-sort var1542 0)
(declare-sort var3177 0)
(declare-sort var2745 0)
(declare-sort var2965 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun attributes/737601183 (var2168) var1542)
(declare-fun var2745_getAttribute/147737434 (var1542 String) var3177)
(declare-fun cast-from-var3177-to-String (var3177) String)
(declare-fun var2965_hasText/2115555376 (String) Bool)
(declare-const null-var2168 var2168)
(declare-const null-var3833 var3833)
(declare-const var3592 var2168) ; Statement: r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator 
(assert (not (= var3592 null-var2168)))
(declare-const var686 var3833) ; Statement: r6 := @parameter0: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var686 null-var3833)))
(define-const var54 var1542 (attributes/737601183 var3592)) ; Statement: $r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: java.util.Map attributes> 
(define-const var2905 var3177 (var2745_getAttribute/147737434 var54 "module")) ; Statement: $r2 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>($r1, "module") 
(define-const var1196 String (cast-from-var3177-to-String var2905)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var3943 Bool (var2965_hasText/2115555376 var1196)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3943 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {attributes/737601183=([org.apache.dubbo.config.spring.reference.ReferenceCreator], java.util.Map), var2745_getAttribute/147737434=([java.util.Map, java.lang.String], java.lang.Object), cast-from-var3177-to-String=([java.lang.Object], java.lang.String), var2965_hasText/2115555376=([java.lang.String], boolean)}
; {var2168=org.apache.dubbo.config.spring.reference.ReferenceCreator, var3592=r0, var3833=org.apache.dubbo.config.ReferenceConfig, var686=r6, var1542=java.util.Map, var54=$r1, var3177=java.lang.Object, var2745=org.apache.dubbo.config.spring.util.AnnotationUtils, var2905=$r2, var1196=r3, var2965=org.springframework.util.StringUtils, var3943=$z0}
; {org.apache.dubbo.config.spring.reference.ReferenceCreator=var2168, r0=var3592, org.apache.dubbo.config.ReferenceConfig=var3833, r6=var686, java.util.Map=var1542, $r1=var54, java.lang.Object=var3177, org.apache.dubbo.config.spring.util.AnnotationUtils=var2745, $r2=var2905, r3=var1196, org.springframework.util.StringUtils=var2965, $z0=var3943}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.reference.ReferenceCreator;	r6 := @parameter0: org.apache.dubbo.config.ReferenceConfig;	$r1 = r0.<org.apache.dubbo.config.spring.reference.ReferenceCreator: java.util.Map attributes>;	$r2 = staticinvoke <org.apache.dubbo.config.spring.util.AnnotationUtils: java.lang.Object getAttribute(java.util.Map,java.lang.String)>($r1, "module");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r3);	if $z0 == 0 goto return;	return
;block_num 2