(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1592 0)
(declare-sort var9 0)
(declare-sort var1794 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1794) void)
(declare-fun cast-from-var1592-to-var1794 (var1592) var1794)
(declare-fun value/-687932879 (var1592) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun category/-687932879 (var1592) String)
(declare-fun serviceInterface/-687932879 (var1592) String)
(declare-fun version/-687932879 (var1592) String)
(declare-fun group/-687932879 (var1592) String)
(declare-const null-var1592 var1592)
(declare-const null-String String)
(declare-const var830 var1592) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var830 null-var1592)))
(declare-const var236 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var236 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1592-to-var1794 var830))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var830!1 var1592)
(declare-const var830!2 var1592)
(assert (not (= var830!2 null-var1592)))
(assert (= (value/-687932879 var830!2) var236)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1 
(define-const var1306 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
; split operation: var638 = var236.split(":", var1306) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1) 
(define-const var1810 String (get_split_element var236 ":" var1306 0)) ; Statement: $r3 = r2[0] 
(declare-const var830!3 var1592)
(assert (not (= var830!3 null-var1592)))
(assert (= (category/-687932879 var830!3) var1810)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3 
(define-const var148 String (get_split_element var236 ":" var1306 1)) ; Statement: $r4 = r2[1] 
(declare-const var830!4 var1592)
(assert (not (= var830!4 null-var1592)))
(assert (= (serviceInterface/-687932879 var830!4) var148)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4 
(define-const var1770 String (get_split_element var236 ":" var1306 2)) ; Statement: $r5 = r2[2] 
(declare-const var830!5 var1592)
(assert (not (= var830!5 null-var1592)))
(assert (= (version/-687932879 var830!5) var1770)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5 
(define-const var3584 String (get_split_element var236 ":" var1306 3)) ; Statement: $r6 = r2[3] 
(declare-const var830!6 var1592)
(assert (not (= var830!6 null-var1592)))
(assert (= (group/-687932879 var830!6) var3584)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1592-to-var1794=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.Object), value/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), cast-from-Int-to-Int=([int], int), category/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), serviceInterface/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), version/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), group/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String)}
; {var1592=org.apache.dubbo.registry.nacos.NacosServiceName, var830=r0, var236=r1, var9=null_type, var1794=java.lang.Object, var1306=$i1, var638=r2, var1810=$r3, var148=$r4, var1770=$r5, var3584=$r6}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var1592, r0=var830, r1=var236, null_type=var9, java.lang.Object=var1794, $i1=var1306, r2=var638, $r3=var1810, $r4=var148, $r5=var1770, $r6=var3584}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1;	$i1 = (int) -1;	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1);	$r3 = r2[0];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3;	$r4 = r2[1];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4;	$r5 = r2[2];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5;	$r6 = r2[3];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6;	return
;block_num 1