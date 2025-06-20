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

(declare-sort var2985 0)
(declare-sort var298 0)
(declare-sort var1207 0)
(declare-sort var319 0)
(declare-sort var679 0)
(declare-sort var1100 0)
(declare-sort var1824 0)
(declare-sort var1966 0)
(declare-sort var1132 0)
(declare-sort var2098 0)
(declare-sort var1757 0)
(declare-sort var1279 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var298-init () var298)
(declare-fun var1207-init () var1207)
(declare-fun var319-init () var319)
(declare-fun <init>/1661516968 (var319) void)
(declare-fun <init>/-1286256707 (var1207 var319) void)
(declare-fun cast-from-var1207-to-var679 (var1207) var679)
(declare-fun <init>/-1955111643 (var298 var679) void)
(declare-fun load/-450207356 (var298 String) var1100)
(declare-fun cast-from-var1100-to-var1824 (var1100) var1824)
(declare-fun var1824_get/1088891777 (var1824 var1100) var1100)
(declare-fun cast-from-String-to-var1100 (String) var1100)
(declare-fun cast-from-var1100-to-String (var1100) String)
(declare-fun var1132_parseFromMap/19623257 (var1824) var1966)
(declare-fun cast-from-var1966-to-var1132 (var1966) var1132)
(declare-fun getConditions/-1506760757 (var1132) var2098)
(declare-fun var1757_isEmpty/73262611 (var1279) Bool)
(declare-fun cast-from-var2098-to-var1279 (var2098) var1279)
(declare-const null-String String)
(declare-const null-var1966 var1966)
(declare-const var1313 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1313 null-String)))
(define-const var2006 var298 var298-init) ; Statement: $r18 = new org.yaml.snakeyaml.Yaml 
(define-const var1190 var1207 var1207-init) ; Statement: $r17 = new org.yaml.snakeyaml.constructor.SafeConstructor 
(define-const var3834 var319 var319-init) ; Statement: $r16 = new org.yaml.snakeyaml.LoaderOptions 
(assert true)
;(assert (<init>/1661516968 var3834)) ; Statement: specialinvoke $r16.<org.yaml.snakeyaml.LoaderOptions: void <init>()>() 

(declare-const var3834!1 var319)
(assert true)
;(assert (<init>/-1286256707 var1190 var3834!1)) ; Statement: specialinvoke $r17.<org.yaml.snakeyaml.constructor.SafeConstructor: void <init>(org.yaml.snakeyaml.LoaderOptions)>($r16) 

(declare-const var1190!1 var1207)
(declare-const var3834!2 var319)
(define-const var612 var679 (cast-from-var1207-to-var679 var1190!1)) ; Statement: $r19 = (org.yaml.snakeyaml.constructor.BaseConstructor) $r17 
(assert true)
;(assert (<init>/-1955111643 var2006 var612)) ; Statement: specialinvoke $r18.<org.yaml.snakeyaml.Yaml: void <init>(org.yaml.snakeyaml.constructor.BaseConstructor)>($r19) 

(declare-const var2006!1 var298)
(declare-const var612!1 var679)
(assert true)
(define-const var1338 var1100 (load/-450207356 var2006!1 var1313)) ; Statement: $r4 = virtualinvoke $r18.<org.yaml.snakeyaml.Yaml: java.lang.Object load(java.lang.String)>(r3) 
(define-const var2927 var1824 (cast-from-var1100-to-var1824 var1338)) ; Statement: r5 = (java.util.Map) $r4 
(define-const var1789 var1100 (var1824_get/1088891777 var2927 (cast-from-String-to-var1100 "configVersion"))) ; Statement: $r6 = interfaceinvoke r5.<java.util.Map: java.lang.Object get(java.lang.Object)>("configVersion") 
(define-const var2748 String (cast-from-var1100-to-String var1789)) ; Statement: r7 = (java.lang.String) $r6 
 ; Statement: if r7 == null goto (branch) 
(assert (= var2748 null-String)) ; Cond: r7 == null 
 ; Statement: if r7 == null goto $r10 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5) 
(assert (= var2748 null-String)) ; Cond: r7 == null 
(define-const var2448 var1966 (var1132_parseFromMap/19623257 var2927)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5) 
(define-const var2658 var1966 var2448) ; Statement: r15 = $r10 
(define-const var1888 var1132 (cast-from-var1966-to-var1132 var2448)) ; Statement: $r8 = (org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule) $r10 
(assert true)
(define-const var1792 var2098 (getConditions/-1506760757 var1888)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: java.util.List getConditions()>() 
(define-const var1827 Bool (var1757_isEmpty/73262611 (cast-from-var2098-to-var1279 var1792))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r9) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var1827 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r15 == null goto return r15 
(assert (= var2658 null-var1966)) ; Cond: r15 == null 
 ; Statement: return r15 
(check-sat)
; {var298-init=([], org.yaml.snakeyaml.Yaml), var1207-init=([], org.yaml.snakeyaml.constructor.SafeConstructor), var319-init=([], org.yaml.snakeyaml.LoaderOptions), <init>/1661516968=([org.yaml.snakeyaml.LoaderOptions], void), <init>/-1286256707=([org.yaml.snakeyaml.constructor.SafeConstructor, org.yaml.snakeyaml.LoaderOptions], void), cast-from-var1207-to-var679=([org.yaml.snakeyaml.constructor.SafeConstructor], org.yaml.snakeyaml.constructor.BaseConstructor), <init>/-1955111643=([org.yaml.snakeyaml.Yaml, org.yaml.snakeyaml.constructor.BaseConstructor], void), load/-450207356=([org.yaml.snakeyaml.Yaml, java.lang.String], java.lang.Object), cast-from-var1100-to-var1824=([java.lang.Object], java.util.Map), var1824_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1100=([java.lang.String], java.lang.Object), cast-from-var1100-to-String=([java.lang.Object], java.lang.String), var1132_parseFromMap/19623257=([java.util.Map], org.apache.dubbo.rpc.cluster.router.AbstractRouterRule), cast-from-var1966-to-var1132=([org.apache.dubbo.rpc.cluster.router.AbstractRouterRule], org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule), getConditions/-1506760757=([org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule], java.util.List), var1757_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2098-to-var1279=([java.util.List], java.util.Collection)}
; {var1313=r3, var2985=null_type, var298=org.yaml.snakeyaml.Yaml, var2006=$r18, var1207=org.yaml.snakeyaml.constructor.SafeConstructor, var1190=$r17, var319=org.yaml.snakeyaml.LoaderOptions, var3834=$r16, var679=org.yaml.snakeyaml.constructor.BaseConstructor, var612=$r19, var1100=java.lang.Object, var1338=$r4, var1824=java.util.Map, var2927=r5, var1789=$r6, var2748=r7, var1966=org.apache.dubbo.rpc.cluster.router.AbstractRouterRule, var1132=org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule, var2448=$r10, var2658=r15, var1888=$r8, var2098=java.util.List, var1792=$r9, var1757=org.apache.dubbo.common.utils.CollectionUtils, var1279=java.util.Collection, var1827=$z0}
; {r3=var1313, null_type=var2985, org.yaml.snakeyaml.Yaml=var298, $r18=var2006, org.yaml.snakeyaml.constructor.SafeConstructor=var1207, $r17=var1190, org.yaml.snakeyaml.LoaderOptions=var319, $r16=var3834, org.yaml.snakeyaml.constructor.BaseConstructor=var679, $r19=var612, java.lang.Object=var1100, $r4=var1338, java.util.Map=var1824, r5=var2927, $r6=var1789, r7=var2748, org.apache.dubbo.rpc.cluster.router.AbstractRouterRule=var1966, org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule=var1132, $r10=var2448, r15=var2658, $r8=var1888, java.util.List=var2098, $r9=var1792, org.apache.dubbo.common.utils.CollectionUtils=var1757, java.util.Collection=var1279, $z0=var1827}
;seq 
;cnt {}
;stmts r3 := @parameter0: java.lang.String;	$r18 = new org.yaml.snakeyaml.Yaml;	$r17 = new org.yaml.snakeyaml.constructor.SafeConstructor;	$r16 = new org.yaml.snakeyaml.LoaderOptions;	specialinvoke $r16.<org.yaml.snakeyaml.LoaderOptions: void <init>()>();	specialinvoke $r17.<org.yaml.snakeyaml.constructor.SafeConstructor: void <init>(org.yaml.snakeyaml.LoaderOptions)>($r16);	$r19 = (org.yaml.snakeyaml.constructor.BaseConstructor) $r17;	specialinvoke $r18.<org.yaml.snakeyaml.Yaml: void <init>(org.yaml.snakeyaml.constructor.BaseConstructor)>($r19);	$r4 = virtualinvoke $r18.<org.yaml.snakeyaml.Yaml: java.lang.Object load(java.lang.String)>(r3);	r5 = (java.util.Map) $r4;	$r6 = interfaceinvoke r5.<java.util.Map: java.lang.Object get(java.lang.Object)>("configVersion");	r7 = (java.lang.String) $r6;	if r7 == null goto (branch);	if r7 == null goto $r10 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5);	$r10 = staticinvoke <org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: org.apache.dubbo.rpc.cluster.router.AbstractRouterRule parseFromMap(java.util.Map)>(r5);	r15 = $r10;	$r8 = (org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule) $r10;	$r9 = virtualinvoke $r8.<org.apache.dubbo.rpc.cluster.router.condition.config.model.ConditionRouterRule: java.util.List getConditions()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r9);	if $z0 == 0 goto (branch);	if r15 == null goto return r15;	return r15
;block_num 5