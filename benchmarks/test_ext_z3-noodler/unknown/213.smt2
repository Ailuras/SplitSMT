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

(declare-sort var3376 0)
(declare-sort var2860 0)
(declare-sort var1396 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun key/-186215082 (var3376) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun value/-186215082 (var3376) var2860)
(declare-fun append/-1031950772 (String var1396) String)
(declare-fun cast-from-var2860-to-var1396 (var2860) var1396)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3376 var3376)
(declare-const var3713 var3376) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch 
(assert (not (= var3713 null-var3376)))
(define-const var2318 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2318)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2318!1 String)
(assert (= var2318!1 ""))
(assert true)
(define-const var1354 String (append/672562846 var2318!1 "ParamMatch{key=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ParamMatch{key=\'") 
(declare-const var2318!2 String)
(assert (= var2318!2 (str.++ var2318!1 "ParamMatch{key=\u0027")))
(define-const var3687 String (key/-186215082 var3713)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch: java.lang.String key> 
(assert true)
(define-const var740 String (append/672562846 var1354 var3687)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1354!1 String)
(assert (= var1354!1 (str.++ var1354 var3687)))
(assert true)
(define-const var90 String (append/-1166366385 var740 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var740!1 String)
(assert (str.prefixof var740 var740!1))
(assert true)
(define-const var2760 String (append/672562846 var90 ", value=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", value=\'") 
(declare-const var90!1 String)
(assert (= var90!1 (str.++ var90 ", value=\u0027")))
(define-const var3970 var2860 (value/-186215082 var3713)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch value> 
(assert true)
(define-const var3755 String (append/-1031950772 var2760 (cast-from-var2860-to-var1396 var3970))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var2760!1 String)
(assert (str.prefixof var2760 var2760!1))
(assert true)
(define-const var3108 String (append/-1166366385 var3755 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3755!1 String)
(assert (str.prefixof var3755 var3755!1))
(assert true)
(define-const var2890 String (append/-1166366385 var3108 125)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3108!1 String)
(assert (str.prefixof var3108 var3108!1))
(assert true)
(define-const var3655 String (toString/-2075883882 var2890)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), key/-186215082=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), value/-186215082=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2860-to-var1396=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3376=org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch, var3713=r1, var2318=$r0, var1354=$r3, var3687=$r2, var740=$r4, var90=$r5, var2760=$r7, var2860=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch, var3970=$r6, var1396=java.lang.Object, var3755=$r8, var3108=$r9, var2890=$r10, var3655=$r11}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch=var3376, r1=var3713, $r0=var2318, $r3=var1354, $r2=var3687, $r4=var740, $r5=var90, $r7=var2760, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch=var2860, $r6=var3970, java.lang.Object=var1396, $r8=var3755, $r9=var3108, $r10=var2890, $r11=var3655}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ParamMatch{key=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch: java.lang.String key>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", value=\'");	$r6 = r1.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ParamMatch: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch value>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 1