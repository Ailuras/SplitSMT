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

(declare-sort var373 0)
(declare-sort var3867 0)
(declare-sort var3158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun expressions/95954273 (var373) var3867)
(declare-fun append/-1031950772 (String var3158) String)
(declare-fun cast-from-var3867-to-var3158 (var3867) var3158)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var373 var373)
(declare-const var3802 var373) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition 
(assert (not (= var3802 null-var373)))
(define-const var839 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var839)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var839!1 String)
(assert (= var839!1 ""))
(assert true)
(define-const var620 String (append/672562846 var839!1 "ConsumesCondition{mediaTypes=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConsumesCondition{mediaTypes=") 
(declare-const var839!2 String)
(assert (= var839!2 (str.++ var839!1 "ConsumesCondition{mediaTypes=")))
(define-const var377 var3867 (expressions/95954273 var3802)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition: java.util.List expressions> 
(assert true)
(define-const var2502 String (append/-1031950772 var620 (cast-from-var3867-to-var3158 var377))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var620!1 String)
(assert (str.prefixof var620 var620!1))
(assert true)
(define-const var249 String (append/-1166366385 var2502 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2502!1 String)
(assert (str.prefixof var2502 var2502!1))
(assert true)
(define-const var2543 String (toString/-2075883882 var249)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), expressions/95954273=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition], java.util.List), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3867-to-var3158=([java.util.List], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var373=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition, var3802=r1, var839=$r0, var620=$r3, var3867=java.util.List, var377=$r2, var3158=java.lang.Object, var2502=$r4, var249=$r5, var2543=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition=var373, r1=var3802, $r0=var839, $r3=var620, java.util.List=var3867, $r2=var377, java.lang.Object=var3158, $r4=var2502, $r5=var249, $r6=var2543}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConsumesCondition{mediaTypes=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.ConsumesCondition: java.util.List expressions>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1