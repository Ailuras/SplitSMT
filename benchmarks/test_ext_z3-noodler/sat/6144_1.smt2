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

(declare-sort var739 0)
(declare-sort var887 0)
(declare-sort var1608 0)
(declare-sort var2978 0)
(declare-sort var1361 0)
(declare-sort var2187 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var887-init () var887)
(declare-fun <init>/-325640736 (var887) void)
(declare-fun getId/-1659575909 (var739) String)
(declare-fun var1608_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1361_getProperty/1261596121 (var2978 String) var2978)
(declare-fun cast-from-var739-to-var2978 (var739) var2978)
(declare-fun cast-from-var2978-to-String (var2978) String)
(declare-fun getClass/1258963082 (var2978) ClassObject)
(declare-fun var739_getTypePrefix/-1434020924 (ClassObject) String)
(declare-fun var2187_add/328494887 (var2187 var2978) Bool)
(declare-fun cast-from-var887-to-var2187 (var887) var2187)
(declare-fun cast-from-String-to-var2978 (String) var2978)
(declare-const null-var739 var739)
(declare-const var1490 var739) ; Statement: r1 := @this: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var1490 null-var739)))
(define-const var2385 var887 var887-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2385)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2385!1 var887)
(assert true)
(define-const var1614 String (getId/-1659575909 var1490)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.config.AbstractConfig: java.lang.String getId()>() 
(define-const var3416 Bool (var1608_hasText/853333513 (cast-from-String-to-String var1614))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Object getProperty(java.lang.Object,java.lang.String)>(r1, "getName") 
(assert (= (ite var3416 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2628 var2978 (var1361_getProperty/1261596121 (cast-from-var739-to-var2978 var1490) "getName")) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Object getProperty(java.lang.Object,java.lang.String)>(r1, "getName") 
(define-const var1231 String (cast-from-var2978-to-String var2628)) ; Statement: $r21 = (java.lang.String) $r3 
(define-const var2774 Bool (var1608_hasText/853333513 (cast-from-String-to-String var1231))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r21) 
 ; Statement: if $z1 == 0 goto $r22 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert (= (ite var2774 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var1037 ClassObject (getClass/1258963082 (cast-from-var739-to-var2978 var1490))) ; Statement: $r22 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var960 String (var739_getTypePrefix/-1434020924 var1037)) ; Statement: $r23 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTypePrefix(java.lang.Class)>($r22) 
;(assert (var2187_add/328494887 (cast-from-var887-to-var2187 var2385!1) (cast-from-String-to-var2978 var960))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r23) 

(declare-const var2385!2 var887)
(declare-const var960!1 String)
 ; Statement: return $r0 
(check-sat)
; {var887-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getId/-1659575909=([org.apache.dubbo.config.AbstractConfig], java.lang.String), var1608_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1361_getProperty/1261596121=([java.lang.Object, java.lang.String], java.lang.Object), cast-from-var739-to-var2978=([org.apache.dubbo.config.AbstractConfig], java.lang.Object), cast-from-var2978-to-String=([java.lang.Object], java.lang.String), getClass/1258963082=([java.lang.Object], java.lang.Class), var739_getTypePrefix/-1434020924=([java.lang.Class], java.lang.String), var2187_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var887-to-var2187=([java.util.ArrayList], java.util.List), cast-from-String-to-var2978=([java.lang.String], java.lang.Object)}
; {var739=org.apache.dubbo.config.AbstractConfig, var1490=r1, var887=java.util.ArrayList, var2385=$r0, var1614=$r2, var1608=org.apache.dubbo.common.utils.StringUtils, var3416=$z0, var2978=java.lang.Object, var1361=org.apache.dubbo.common.utils.ReflectUtils, var2628=$r3, var1231=$r21, var2774=$z1, var1037=$r22, var960=$r23, var2187=java.util.List}
; {org.apache.dubbo.config.AbstractConfig=var739, r1=var1490, java.util.ArrayList=var887, $r0=var2385, $r2=var1614, org.apache.dubbo.common.utils.StringUtils=var1608, $z0=var3416, java.lang.Object=var2978, org.apache.dubbo.common.utils.ReflectUtils=var1361, $r3=var2628, $r21=var1231, $z1=var2774, $r22=var1037, $r23=var960, java.util.List=var2187}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 2}
;stmts r1 := @this: org.apache.dubbo.config.AbstractConfig;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.config.AbstractConfig: java.lang.String getId()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r2);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Object getProperty(java.lang.Object,java.lang.String)>(r1, "getName");	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Object getProperty(java.lang.Object,java.lang.String)>(r1, "getName");	$r21 = (java.lang.String) $r3;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r21);	if $z1 == 0 goto $r22 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r22 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r23 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getTypePrefix(java.lang.Class)>($r22);	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r23);	return $r0
;block_num 3