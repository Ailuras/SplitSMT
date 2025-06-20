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

(declare-sort var2901 0)
(declare-sort var1211 0)
(declare-sort var2718 0)
(declare-sort var3090 0)
(declare-sort var304 0)
(declare-sort var1118 0)
(declare-sort var2372 0)
(declare-sort var676 0)
(declare-sort var3776 0)
(declare-sort var2314 0)
(declare-sort var101 0)
(declare-sort var870 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1211-init () var1211)
(declare-fun var2718-init () var2718)
(declare-fun var3090-init () var3090)
(declare-fun <init>/1661516968 (var3090) void)
(declare-fun <init>/-1286256707 (var2718 var3090) void)
(declare-fun cast-from-var2718-to-var304 (var2718) var304)
(declare-fun <init>/-1955111643 (var1211 var304) void)
(declare-fun load/-450207356 (var1211 String) var1118)
(declare-fun cast-from-var1118-to-var2372 (var1118) var2372)
(declare-fun var2372_get/1088891777 (var2372 var1118) var1118)
(declare-fun cast-from-String-to-var1118 (String) var1118)
(declare-fun cast-from-var1118-to-String (var1118) String)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun var3776_parseFromMap/-1388298572 (var2372) var676)
(declare-fun cast-from-var676-to-var3776 (var676) var3776)
(declare-fun getConditions/-434397018 (var3776) var2314)
(declare-fun var101_isEmpty/73262611 (var870) Bool)
(declare-fun cast-from-var2314-to-var870 (var2314) var870)
(declare-const null-String String)
(declare-const null-var676 var676)
(declare-const var3574 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3574 null-String)))
(define-const var3823 var1211 var1211-init) ; Statement: $r18 = new org.yaml.snakeyaml.Yaml 
(define-const var2381 var2718 var2718-init) ; Statement: $r17 = new org.yaml.snakeyaml.constructor.SafeConstructor 
(define-const var3210 var3090 var3090-init) ; Statement: $r16 = new org.yaml.snakeyaml.LoaderOptions 
(assert true)
;(assert (<init>/1661516968 var3210)) ; Statement: specialinvoke $r16.<org.yaml.snakeyaml.LoaderOptions: void <init>()>() 

(declare-const var3210!1 var3090)
(assert true)
;(assert (<init>/-1286256707 var2381 var3210!1)) ; Statement: specialinvoke $r17.<org.yaml.snakeyaml.constructor.SafeConstructor: void <init>(org.yaml.snakeyaml.LoaderOptions)>($r16) 

(declare-const var2381!1 var2718)
(declare-const var3210!2 var3090)
(define-const var1456 var304 (cast-from-var2718-to-var304 var2381!1)) ; Statement: $r19 = (org.yaml.snakeyaml.constructor.BaseConstructor) $r17 
(assert true)
;(assert (<init>/-1955111643 var3823 var1456)) ; Statement: specialinvoke $r18.<org.yaml.snakeyaml.Yaml: void <init>(org.yaml.snakeyaml.constructor.BaseConstructor)>($r19) 

(declare-const var3823!1 var1211)
(declare-const var1456!1 var304)
(assert true)
(define-const var3541 var1118 (load/-450207356 var3823!1 var3574)) ; Statement: $r4 = virtualinvoke $r18.<org.yaml.snakeyaml.Yaml: java.lang.Object load(java.lang.String)>(r3) 
(define-const var3183 var2372 (cast-from-var1118-to-var2372 var3541)) ; Statement: r5 = (java.util.Map) $r4 
(define-const var228 var1118 (var2372_get/1088891777 var3183 (cast-from-String-to-var1118 "configVersion"))) ; Statement: $r6 = interfaceinvoke r5.<java.util.Map: java.lang.Object get(java.lang.Object)>("configVersion") 
(define-const var744 String (cast-from-var1118-to-String var228)) ; Statement: r7 = (java.lang.String) $r6 
 ; Statement: if r7 == null goto (branch) 
(assert (not (= var744 null-String))) ; Negate: Cond: r7 == null  
(assert true)
(define-const var1685 String (toLowerCase/415700667 var744)) ; Statement: $r12 = virtualinvoke r7.<java.lang.String: java.lang.String toLowerCase()>() 
(assert true)
(define-const var2999 Bool (startsWith/-1785782452 var1685 "v3.1")) ; Statement: $z1 = virtualinvoke $r12.<java.lang.String: boolean startsWith(java.lang.String)>("v3.1") 
 ; Statement: if $z1 == 0 goto (branch) 
(assert (not (= (ite var2999 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2580 var676 (var3776_parseFromMap/-1388298572 var3183)) ; Statement: r15 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5) 
(define-const var2885 var3776 (cast-from-var676-to-var3776 var2580)) ; Statement: $r13 = (org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule) r15 
(assert true)
(define-const var2550 var2314 (getConditions/-434397018 var2885)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule: java.util.List getConditions()>() 
(define-const var1927 Bool (var101_isEmpty/73262611 (cast-from-var2314-to-var870 var2550))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r14) 
 ; Statement: if $z2 == 0 goto (branch) 
(assert (= (ite var1927 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: if r15 == null goto return r15 
(assert (= var2580 null-var676)) ; Cond: r15 == null 
 ; Statement: return r15 
(check-sat)
; {var1211-init=([], org.yaml.snakeyaml.Yaml), var2718-init=([], org.yaml.snakeyaml.constructor.SafeConstructor), var3090-init=([], org.yaml.snakeyaml.LoaderOptions), <init>/1661516968=([org.yaml.snakeyaml.LoaderOptions], void), <init>/-1286256707=([org.yaml.snakeyaml.constructor.SafeConstructor, org.yaml.snakeyaml.LoaderOptions], void), cast-from-var2718-to-var304=([org.yaml.snakeyaml.constructor.SafeConstructor], org.yaml.snakeyaml.constructor.BaseConstructor), <init>/-1955111643=([org.yaml.snakeyaml.Yaml, org.yaml.snakeyaml.constructor.BaseConstructor], void), load/-450207356=([org.yaml.snakeyaml.Yaml, java.lang.String], java.lang.Object), cast-from-var1118-to-var2372=([java.lang.Object], java.util.Map), var2372_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1118=([java.lang.String], java.lang.Object), cast-from-var1118-to-String=([java.lang.Object], java.lang.String), toLowerCase/415700667=([java.lang.String], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), var3776_parseFromMap/-1388298572=([java.util.Map], org.apache.dubbo.rpc.cluster.router.AbstractRouterRule), cast-from-var676-to-var3776=([org.apache.dubbo.rpc.cluster.router.AbstractRouterRule], org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule), getConditions/-434397018=([org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule], java.util.List), var101_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2314-to-var870=([java.util.List], java.util.Collection)}
; {var3574=r3, var2901=null_type, var1211=org.yaml.snakeyaml.Yaml, var3823=$r18, var2718=org.yaml.snakeyaml.constructor.SafeConstructor, var2381=$r17, var3090=org.yaml.snakeyaml.LoaderOptions, var3210=$r16, var304=org.yaml.snakeyaml.constructor.BaseConstructor, var1456=$r19, var1118=java.lang.Object, var3541=$r4, var2372=java.util.Map, var3183=r5, var228=$r6, var744=r7, var1685=$r12, var2999=$z1, var676=org.apache.dubbo.rpc.cluster.router.AbstractRouterRule, var3776=org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule, var2580=r15, var2885=$r13, var2314=java.util.List, var2550=$r14, var101=org.apache.dubbo.common.utils.CollectionUtils, var870=java.util.Collection, var1927=$z2}
; {r3=var3574, null_type=var2901, org.yaml.snakeyaml.Yaml=var1211, $r18=var3823, org.yaml.snakeyaml.constructor.SafeConstructor=var2718, $r17=var2381, org.yaml.snakeyaml.LoaderOptions=var3090, $r16=var3210, org.yaml.snakeyaml.constructor.BaseConstructor=var304, $r19=var1456, java.lang.Object=var1118, $r4=var3541, java.util.Map=var2372, r5=var3183, $r6=var228, r7=var744, $r12=var1685, $z1=var2999, org.apache.dubbo.rpc.cluster.router.AbstractRouterRule=var676, org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule=var3776, r15=var2580, $r13=var2885, java.util.List=var2314, $r14=var2550, org.apache.dubbo.common.utils.CollectionUtils=var101, java.util.Collection=var870, $z2=var1927}
;seq <java.lang.String: java.lang.String toLowerCase()>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toLowerCase()>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r3 := @parameter0: java.lang.String;	$r18 = new org.yaml.snakeyaml.Yaml;	$r17 = new org.yaml.snakeyaml.constructor.SafeConstructor;	$r16 = new org.yaml.snakeyaml.LoaderOptions;	specialinvoke $r16.<org.yaml.snakeyaml.LoaderOptions: void <init>()>();	specialinvoke $r17.<org.yaml.snakeyaml.constructor.SafeConstructor: void <init>(org.yaml.snakeyaml.LoaderOptions)>($r16);	$r19 = (org.yaml.snakeyaml.constructor.BaseConstructor) $r17;	specialinvoke $r18.<org.yaml.snakeyaml.Yaml: void <init>(org.yaml.snakeyaml.constructor.BaseConstructor)>($r19);	$r4 = virtualinvoke $r18.<org.yaml.snakeyaml.Yaml: java.lang.Object load(java.lang.String)>(r3);	r5 = (java.util.Map) $r4;	$r6 = interfaceinvoke r5.<java.util.Map: java.lang.Object get(java.lang.Object)>("configVersion");	r7 = (java.lang.String) $r6;	if r7 == null goto (branch);	$r12 = virtualinvoke r7.<java.lang.String: java.lang.String toLowerCase()>();	$z1 = virtualinvoke $r12.<java.lang.String: boolean startsWith(java.lang.String)>("v3.1");	if $z1 == 0 goto (branch);	r15 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5);	$r13 = (org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule) r15;	$r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.cluster.router.condition.config.model.MultiDestConditionRouterRule: java.util.List getConditions()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r14);	if $z2 == 0 goto (branch);	if r15 == null goto return r15;	return r15
;block_num 5