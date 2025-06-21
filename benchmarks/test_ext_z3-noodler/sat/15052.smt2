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

(declare-sort var3696 0)
(declare-sort var869 0)
(declare-sort var1388 0)
(declare-sort var3175 0)
(declare-sort var199 0)
(declare-sort var1350 0)
(declare-sort var3263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var199-init () var199)
(declare-fun <init>/1228603609 (var199 Int) void)
(declare-fun cast-from-var199-to-var1350 (var199) var1350)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-fun var3263_isNotEmpty/-572947236 (var3175) Bool)
(declare-fun var1350_isEmpty/-153543822 (var1350) Bool)
(declare-const null-var3696 var3696)
(declare-const null-var869 var869)
(declare-const null-String String)
(declare-const null-var3175 var3175)
(declare-const var340 var3696) ; Statement: r18 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry 
(assert (not (= var340 null-var3696)))
(declare-const var788 var869) ; Statement: r6 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var788 null-var869)))
(declare-const var1313 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1313 null-String)))
(declare-const var394 var3175) ; Statement: r2 := @parameter2: java.util.Collection 
(assert (not (= var394 null-var3175)))
(define-const var400 var199 var199-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/1228603609 var400 1)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>(int)>(1) 

(declare-const var400!1 var199)
(declare-const var1560 Int)
(define-const var2547 var1350 (cast-from-var199-to-var1350 var400!1)) ; Statement: r20 = $r0 
(assert true)
(define-const var726 Bool (endsWith/985337093 var1313 "providers")) ; Statement: z0 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("providers") 
 ; Statement: if z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r2) 
(assert (= (ite var726 1 0) 0)) ; Cond: z0 == 0 
(define-const var700 Bool (var3263_isNotEmpty/-572947236 var394)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r2) 
 ; Statement: if $z1 == 0 goto $z6 = interfaceinvoke r20.<java.util.List: boolean isEmpty()>() 
(assert (= (ite var700 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1358 Bool (var1350_isEmpty/-153543822 var2547)) ; Statement: $z6 = interfaceinvoke r20.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z6 == 0 goto return r20 
(assert (= (ite var1358 1 0) 0)) ; Cond: $z6 == 0 
 ; Statement: return r20 
(check-sat)
; {var199-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void), cast-from-var199-to-var1350=([java.util.ArrayList], java.util.List), endsWith/985337093=([java.lang.String, java.lang.String], boolean), var3263_isNotEmpty/-572947236=([java.util.Collection], boolean), var1350_isEmpty/-153543822=([java.util.List], boolean)}
; {var3696=org.apache.dubbo.registry.support.CacheableFailbackRegistry, var340=r18, var869=org.apache.dubbo.common.URL, var788=r6, var1313=r1, var1388=null_type, var3175=java.util.Collection, var394=r2, var199=java.util.ArrayList, var400=$r0, var1560=1, var1350=java.util.List, var2547=r20, var726=z0, var3263=org.apache.dubbo.common.utils.CollectionUtils, var700=$z1, var1358=$z6}
; {org.apache.dubbo.registry.support.CacheableFailbackRegistry=var3696, r18=var340, org.apache.dubbo.common.URL=var869, r6=var788, r1=var1313, null_type=var1388, java.util.Collection=var3175, r2=var394, java.util.ArrayList=var199, $r0=var400, 1=var1560, java.util.List=var1350, r20=var2547, z0=var726, org.apache.dubbo.common.utils.CollectionUtils=var3263, $z1=var700, $z6=var1358}
;seq <java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r18 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry;	r6 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.util.Collection;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>(int)>(1);	r20 = $r0;	z0 = virtualinvoke r1.<java.lang.String: boolean endsWith(java.lang.String)>("providers");	if z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r2);	if $z1 == 0 goto $z6 = interfaceinvoke r20.<java.util.List: boolean isEmpty()>();	$z6 = interfaceinvoke r20.<java.util.List: boolean isEmpty()>();	if $z6 == 0 goto return r20;	return r20
;block_num 4