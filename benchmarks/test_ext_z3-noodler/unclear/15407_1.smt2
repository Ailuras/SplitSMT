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

(declare-sort var1080 0)
(declare-sort var22 0)
(declare-sort var2504 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2504) void)
(declare-fun cast-from-var1080-to-var2504 (var1080) var2504)
(declare-fun value/-687932879 (var1080) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun category/-687932879 (var1080) String)
(declare-fun serviceInterface/-687932879 (var1080) String)
(declare-fun version/-687932879 (var1080) String)
(declare-fun group/-687932879 (var1080) String)
(declare-const null-var1080 var1080)
(declare-const null-String String)
(declare-const var2787 var1080) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var2787 null-var1080)))
(declare-const var3696 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3696 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1080-to-var2504 var2787))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2787!1 var1080)
(declare-const var2787!2 var1080)
(assert (not (= var2787!2 null-var1080)))
(assert (= (value/-687932879 var2787!2) var3696)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1 
(define-const var3154 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
; split operation: var2887 = var3696.split(":", var3154) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1) 
(define-const var2714 String (get_split_element var3696 ":" var3154 0)) ; Statement: $r3 = r2[0] 
(declare-const var2787!3 var1080)
(assert (not (= var2787!3 null-var1080)))
(assert (= (category/-687932879 var2787!3) var2714)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3 
(define-const var2443 String (get_split_element var3696 ":" var3154 1)) ; Statement: $r4 = r2[1] 
(declare-const var2787!4 var1080)
(assert (not (= var2787!4 null-var1080)))
(assert (= (serviceInterface/-687932879 var2787!4) var2443)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4 
(define-const var3828 String (get_split_element var3696 ":" var3154 2)) ; Statement: $r5 = r2[2] 
(declare-const var2787!5 var1080)
(assert (not (= var2787!5 null-var1080)))
(assert (= (version/-687932879 var2787!5) var3828)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5 
(define-const var972 String (get_split_element var3696 ":" var3154 3)) ; Statement: $r6 = r2[3] 
(declare-const var2787!6 var1080)
(assert (not (= var2787!6 null-var1080)))
(assert (= (group/-687932879 var2787!6) var972)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1080-to-var2504=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.Object), value/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), cast-from-Int-to-Int=([int], int), category/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), serviceInterface/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), version/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), group/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String)}
; {var1080=org.apache.dubbo.registry.nacos.NacosServiceName, var2787=r0, var3696=r1, var22=null_type, var2504=java.lang.Object, var3154=$i1, var2887=r2, var2714=$r3, var2443=$r4, var3828=$r5, var972=$r6}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var1080, r0=var2787, r1=var3696, null_type=var22, java.lang.Object=var2504, $i1=var3154, r2=var2887, $r3=var2714, $r4=var2443, $r5=var3828, $r6=var972}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1;	$i1 = (int) -1;	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1);	$r3 = r2[0];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3;	$r4 = r2[1];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4;	$r5 = r2[2];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5;	$r6 = r2[3];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6;	return
;block_num 1