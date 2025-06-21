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

(declare-sort var3817 0)
(declare-sort var1594 0)
(declare-sort var2328 0)
(declare-sort var3566 0)
(declare-sort var365 0)
(declare-sort var2907 0)
(declare-sort var3507 0)
(declare-sort var1381 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3566) void)
(declare-fun cast-from-var3817-to-var3566 (var3817) var3566)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun hashCodeCache/1606454354 (var3817) Int)
(declare-fun var365_isEmpty/-813097145 (String) Bool)
(declare-fun var2907-init () var2907)
(declare-fun <init>/-1140704096 (var2907 String String String String String Int) void)
(declare-fun cast-from-var2907-to-var3507 (var2907) var3507)
(declare-fun urlAddress/1606454354 (var3817) var3507)
(declare-fun var1381_parse/-1948119116 (var2328) var1381)
(declare-fun urlParam/1606454354 (var3817) var1381)
(declare-fun attributes/1606454354 (var3817) var2328)
(declare-const null-var3817 var3817)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var2328 var2328)
(declare-const var609 var3817) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var609 null-var3817)))
(declare-const var2091 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var2091 null-String)))
(declare-const var2157 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2157 null-String)))
(declare-const var899 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var899 null-String)))
(declare-const var796 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var796 null-String)))
(declare-const var560 Int) ; Statement: i0 := @parameter4: int 
(assert (not (= var560 null-Int)))
(declare-const var2392 String) ; Statement: r5 := @parameter5: java.lang.String 
(assert (not (= var2392 null-String)))
(declare-const var1377 var2328) ; Statement: r7 := @parameter6: java.util.Map 
(assert (not (= var1377 null-var2328)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3817-to-var3566 var609))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var609!1 var3817)
(define-const var127 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
(declare-const var609!2 var3817)
(assert (not (= var609!2 null-var3817)))
(assert (= (hashCodeCache/1606454354 var609!2) var127)) ; Statement: r0.<org.apache.dubbo.common.URL: int hashCodeCache> = $i2 
(define-const var1389 Bool (var365_isEmpty/-813097145 var2157)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r11 = new org.apache.dubbo.common.url.component.PathURLAddress 
(assert (= (ite var1389 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2850 var2907 var2907-init) ; Statement: $r11 = new org.apache.dubbo.common.url.component.PathURLAddress 
(assert true)
;(assert (<init>/-1140704096 var2850 var2091 var2157 var899 var2392 var796 var560)) ; Statement: specialinvoke $r11.<org.apache.dubbo.common.url.component.PathURLAddress: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,int)>(r3, r1, r4, r5, r6, i0) 

(declare-const var2850!1 var2907)
(declare-const var2091!1 String)
(declare-const var2157!1 String)
(declare-const var899!1 String)
(declare-const var2392!1 String)
(declare-const var796!1 String)
(declare-const var560!1 Int)
(declare-const var609!3 var3817)
(assert (not (= var609!3 null-var3817)))
(assert (= (urlAddress/1606454354 var609!3) (cast-from-var2907-to-var3507 var2850!1))) ; Statement: r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> = $r11 
(define-const var612 var1381 (var1381_parse/-1948119116 var1377)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.url.component.URLParam: org.apache.dubbo.common.url.component.URLParam parse(java.util.Map)>(r7) 
(declare-const var609!4 var3817)
(assert (not (= var609!4 null-var3817)))
(assert (= (urlParam/1606454354 var609!4) var612)) ; Statement: r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLParam urlParam> = $r8 
(declare-const var609!5 var3817)
(assert (not (= var609!5 null-var3817)))
(assert (= (attributes/1606454354 var609!5) null-var2328)) ; Statement: r0.<org.apache.dubbo.common.URL: java.util.Map attributes> = null 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3817-to-var3566=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-Int-to-Int=([int], int), hashCodeCache/1606454354=([org.apache.dubbo.common.URL], int), var365_isEmpty/-813097145=([java.lang.String], boolean), var2907-init=([], org.apache.dubbo.common.url.component.PathURLAddress), <init>/-1140704096=([org.apache.dubbo.common.url.component.PathURLAddress, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int], void), cast-from-var2907-to-var3507=([org.apache.dubbo.common.url.component.PathURLAddress], org.apache.dubbo.common.url.component.URLAddress), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), var1381_parse/-1948119116=([java.util.Map], org.apache.dubbo.common.url.component.URLParam), urlParam/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLParam), attributes/1606454354=([org.apache.dubbo.common.URL], java.util.Map)}
; {var3817=org.apache.dubbo.common.URL, var609=r0, var2091=r3, var1594=null_type, var2157=r1, var899=r4, var796=r6, var560=i0, var2392=r5, var2328=java.util.Map, var1377=r7, var3566=java.lang.Object, var127=$i2, var365=org.apache.dubbo.common.utils.StringUtils, var1389=$z0, var2907=org.apache.dubbo.common.url.component.PathURLAddress, var2850=$r11, var3507=org.apache.dubbo.common.url.component.URLAddress, var1381=org.apache.dubbo.common.url.component.URLParam, var612=$r8}
; {org.apache.dubbo.common.URL=var3817, r0=var609, r3=var2091, null_type=var1594, r1=var2157, r4=var899, r6=var796, i0=var560, r5=var2392, java.util.Map=var2328, r7=var1377, java.lang.Object=var3566, $i2=var127, org.apache.dubbo.common.utils.StringUtils=var365, $z0=var1389, org.apache.dubbo.common.url.component.PathURLAddress=var2907, $r11=var2850, org.apache.dubbo.common.url.component.URLAddress=var3507, org.apache.dubbo.common.url.component.URLParam=var1381, $r8=var612}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.String;	i0 := @parameter4: int;	r5 := @parameter5: java.lang.String;	r7 := @parameter6: java.util.Map;	specialinvoke r0.<java.lang.Object: void <init>()>();	$i2 = (int) -1;	r0.<org.apache.dubbo.common.URL: int hashCodeCache> = $i2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r11 = new org.apache.dubbo.common.url.component.PathURLAddress;	$r11 = new org.apache.dubbo.common.url.component.PathURLAddress;	specialinvoke $r11.<org.apache.dubbo.common.url.component.PathURLAddress: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,int)>(r3, r1, r4, r5, r6, i0);	r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> = $r11;	$r8 = staticinvoke <org.apache.dubbo.common.url.component.URLParam: org.apache.dubbo.common.url.component.URLParam parse(java.util.Map)>(r7);	r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLParam urlParam> = $r8;	r0.<org.apache.dubbo.common.URL: java.util.Map attributes> = null;	return
;block_num 2