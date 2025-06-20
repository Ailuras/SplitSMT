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

(declare-sort var2887 0)
(declare-sort var1729 0)
(declare-sort var916 0)
(declare-sort var3918 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceKey/1456125852 (var1729) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var2887_get/1088891777 (var2887 var3918) var3918)
(declare-fun cast-from-String-to-var3918 (String) var3918)
(declare-fun cast-from-var3918-to-var916 (var3918) var916)
(declare-const null-var2887 var2887)
(declare-const null-var1729 var1729)
(declare-const null-var916 var916)
(declare-const var1741 var2887) ; Statement: r2 := @parameter0: java.util.Map 
(assert (not (= var1741 null-var2887)))
(declare-const var717 var1729) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var717 null-var1729)))
(define-const var3649 var916 null-var916) ; Statement: r11 = null 
(assert true)
(define-const var2042 String (getServiceKey/1456125852 var717)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2723 Bool (contains/1009244746 var2042 (cast-from-String-to-String "*"))) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("*") 
 ; Statement: if $z0 != 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2) 
(assert (not (not (= (ite var2723 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var52 String (getServiceKey/1456125852 var717)) ; Statement: $r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(define-const var893 var3918 (var2887_get/1088891777 var1741 (cast-from-String-to-var3918 var52))) ; Statement: $r10 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r9) 
(define-const var3649!1 var916 (cast-from-var3918-to-var916 var893)) ; Statement: r11 = (org.apache.dubbo.rpc.Exporter) $r10 
 ; Statement: goto [?= return r11] 
(assert true) ; Non Conditional
 ; Statement: return r11 
(check-sat)
; {getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var2887_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3918=([java.lang.String], java.lang.Object), cast-from-var3918-to-var916=([java.lang.Object], org.apache.dubbo.rpc.Exporter)}
; {var2887=java.util.Map, var1741=r2, var1729=org.apache.dubbo.common.URL, var717=r0, var916=org.apache.dubbo.rpc.Exporter, var3649=r11, var2042=$r1, var2723=$z0, var52=$r9, var3918=java.lang.Object, var893=$r10}
; {java.util.Map=var2887, r2=var1741, org.apache.dubbo.common.URL=var1729, r0=var717, org.apache.dubbo.rpc.Exporter=var916, r11=var3649, $r1=var2042, $z0=var2723, $r9=var52, java.lang.Object=var3918, $r10=var893}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r2 := @parameter0: java.util.Map;	r0 := @parameter1: org.apache.dubbo.common.URL;	r11 = null;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>("*");	if $z0 != 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r2);	$r9 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r10 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r9);	r11 = (org.apache.dubbo.rpc.Exporter) $r10;	goto [?= return r11];	return r11
;block_num 3