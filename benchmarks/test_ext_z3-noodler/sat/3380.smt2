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

(declare-sort var1533 0)
(declare-sort var2255 0)
(declare-sort var2856 0)
(declare-sort var1660 0)
(declare-sort var732 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1533_get/1088891777 (var1533 var1660) var1660)
(declare-fun cast-from-String-to-var1660 (String) var1660)
(declare-fun cast-from-var1660-to-String (var1660) String)
(declare-fun var732_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1533_put/1464166817 (var1533 var1660 var1660) var1660)
(declare-const null-var1533 var1533)
(declare-const null-String String)
(declare-const var2856-PARAM_KEY_CACHE var1533)
(declare-const var2856-PARAM_VALUE_CACHE var1533)
(declare-const var2044 var1533) ; Statement: r6 := @parameter0: java.util.Map 
(assert (not (= var2044 null-var1533)))
(declare-const var3800 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3800 null-String)))
(declare-const var1472 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1472 null-String)))
(define-const var1689 var1533 var2856-PARAM_KEY_CACHE) ; Statement: $r1 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_KEY_CACHE> 
(define-const var3693 var1660 (var1533_get/1088891777 var1689 (cast-from-String-to-var1660 var3800))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0) 
(define-const var2211 String (cast-from-var1660-to-String var3693)) ; Statement: r10 = (java.lang.String) $r2 
(define-const var3913 Bool (var732_isBlank/-523695098 (cast-from-String-to-String var2211))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
 ; Statement: if $z0 == 0 goto $r4 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_VALUE_CACHE> 
(assert (= (ite var3913 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2473 var1533 var2856-PARAM_VALUE_CACHE) ; Statement: $r4 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_VALUE_CACHE> 
(define-const var1486 var1660 (var1533_get/1088891777 var2473 (cast-from-String-to-var1660 var1472))) ; Statement: $r5 = interfaceinvoke $r4.<java.util.Map: java.lang.Object get(java.lang.Object)>(r3) 
(define-const var2400 String (cast-from-var1660-to-String var1486)) ; Statement: $r9 = (java.lang.String) $r5 
(define-const var3554 String var2400) ; Statement: r11 = $r9 
(define-const var700 Bool (var732_isBlank/-523695098 (cast-from-String-to-String var2400))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r9) 
 ; Statement: if $z1 == 0 goto interfaceinvoke r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r10, r11) 
(assert (= (ite var700 1 0) 0)) ; Cond: $z1 == 0 
;(assert (var1533_put/1464166817 var2044 (cast-from-String-to-var1660 var2211) (cast-from-String-to-var1660 var3554))) ; Statement: interfaceinvoke r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r10, r11) 

(declare-const var2044!1 var1533)
(declare-const var2211!1 String)
(declare-const var3554!1 String)
 ; Statement: return 
(check-sat)
; {var1533_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1660=([java.lang.String], java.lang.Object), cast-from-var1660-to-String=([java.lang.Object], java.lang.String), var732_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1533_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object)}
; {var1533=java.util.Map, var2044=r6, var3800=r0, var2255=null_type, var1472=r3, var2856=org.apache.dubbo.common.url.component.URLItemCache, var1689=$r1, var1660=java.lang.Object, var3693=$r2, var2211=r10, var732=org.apache.dubbo.common.utils.StringUtils, var3913=$z0, var2473=$r4, var1486=$r5, var2400=$r9, var3554=r11, var700=$z1}
; {java.util.Map=var1533, r6=var2044, r0=var3800, null_type=var2255, r3=var1472, org.apache.dubbo.common.url.component.URLItemCache=var2856, $r1=var1689, java.lang.Object=var1660, $r2=var3693, r10=var2211, org.apache.dubbo.common.utils.StringUtils=var732, $z0=var3913, $r4=var2473, $r5=var1486, $r9=var2400, r11=var3554, $z1=var700}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 2}
;stmts r6 := @parameter0: java.util.Map;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	$r1 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_KEY_CACHE>;	$r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>(r0);	r10 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	if $z0 == 0 goto $r4 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_VALUE_CACHE>;	$r4 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PARAM_VALUE_CACHE>;	$r5 = interfaceinvoke $r4.<java.util.Map: java.lang.Object get(java.lang.Object)>(r3);	$r9 = (java.lang.String) $r5;	r11 = $r9;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r9);	if $z1 == 0 goto interfaceinvoke r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r10, r11);	interfaceinvoke r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r10, r11);	return
;block_num 3