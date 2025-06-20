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

(declare-sort var62 0)
(declare-sort var3293 0)
(declare-sort var2711 0)
(declare-sort var2725 0)
(declare-sort var3119 0)
(declare-sort var3135 0)
(declare-sort var2468 0)
(declare-sort var728 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2725) void)
(declare-fun cast-from-var62-to-var2725 (var62) var2725)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun hashCodeCache/1606454354 (var62) Int)
(declare-fun var3119_isEmpty/-813097145 (String) Bool)
(declare-fun var3135-init () var3135)
(declare-fun <init>/-1140704096 (var3135 String String String String String Int) void)
(declare-fun cast-from-var3135-to-var2468 (var3135) var2468)
(declare-fun urlAddress/1606454354 (var62) var2468)
(declare-fun var728_parse/-1948119116 (var2711) var728)
(declare-fun urlParam/1606454354 (var62) var728)
(declare-fun attributes/1606454354 (var62) var2711)
(declare-const null-var62 var62)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var2711 var2711)
(declare-const null-Bool Bool)
(declare-const var462 var62) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var462 null-var62)))
(declare-const var1215 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1215 null-String)))
(declare-const var3890 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3890 null-String)))
(declare-const var1527 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var1527 null-String)))
(declare-const var3529 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var3529 null-String)))
(declare-const var3914 Int) ; Statement: i0 := @parameter4: int 
(assert (not (= var3914 null-Int)))
(declare-const var3053 String) ; Statement: r5 := @parameter5: java.lang.String 
(assert (not (= var3053 null-String)))
(declare-const var292 var2711) ; Statement: r7 := @parameter6: java.util.Map 
(assert (not (= var292 null-var2711)))
(declare-const var3636 Bool) ; Statement: z2 := @parameter7: boolean 
(assert (not (= var3636 null-Bool)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var62-to-var2725 var462))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var462!1 var62)
(define-const var1265 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
(declare-const var462!2 var62)
(assert (not (= var462!2 null-var62)))
(assert (= (hashCodeCache/1606454354 var462!2) var1265)) ; Statement: r0.<org.apache.dubbo.common.URL: int hashCodeCache> = $i2 
(define-const var2969 Bool (var3119_isEmpty/-813097145 var3890)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r11 = new org.apache.dubbo.common.url.component.PathURLAddress 
(assert (= (ite var2969 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2307 var3135 var3135-init) ; Statement: $r11 = new org.apache.dubbo.common.url.component.PathURLAddress 
(assert true)
;(assert (<init>/-1140704096 var2307 var1215 var3890 var1527 var3053 var3529 var3914)) ; Statement: specialinvoke $r11.<org.apache.dubbo.common.url.component.PathURLAddress: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,int)>(r3, r1, r4, r5, r6, i0) 

(declare-const var2307!1 var3135)
(declare-const var1215!1 String)
(declare-const var3890!1 String)
(declare-const var1527!1 String)
(declare-const var3053!1 String)
(declare-const var3529!1 String)
(declare-const var3914!1 Int)
(declare-const var462!3 var62)
(assert (not (= var462!3 null-var62)))
(assert (= (urlAddress/1606454354 var462!3) (cast-from-var3135-to-var2468 var2307!1))) ; Statement: r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> = $r11 
(define-const var1117 var728 (var728_parse/-1948119116 var292)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.url.component.URLParam: org.apache.dubbo.common.url.component.URLParam parse(java.util.Map)>(r7) 
(declare-const var462!4 var62)
(assert (not (= var462!4 null-var62)))
(assert (= (urlParam/1606454354 var462!4) var1117)) ; Statement: r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLParam urlParam> = $r8 
(declare-const var462!5 var62)
(assert (not (= var462!5 null-var62)))
(assert (= (attributes/1606454354 var462!5) null-var2711)) ; Statement: r0.<org.apache.dubbo.common.URL: java.util.Map attributes> = null 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var62-to-var2725=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-Int-to-Int=([int], int), hashCodeCache/1606454354=([org.apache.dubbo.common.URL], int), var3119_isEmpty/-813097145=([java.lang.String], boolean), var3135-init=([], org.apache.dubbo.common.url.component.PathURLAddress), <init>/-1140704096=([org.apache.dubbo.common.url.component.PathURLAddress, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int], void), cast-from-var3135-to-var2468=([org.apache.dubbo.common.url.component.PathURLAddress], org.apache.dubbo.common.url.component.URLAddress), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), var728_parse/-1948119116=([java.util.Map], org.apache.dubbo.common.url.component.URLParam), urlParam/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLParam), attributes/1606454354=([org.apache.dubbo.common.URL], java.util.Map)}
; {var62=org.apache.dubbo.common.URL, var462=r0, var1215=r3, var3293=null_type, var3890=r1, var1527=r4, var3529=r6, var3914=i0, var3053=r5, var2711=java.util.Map, var292=r7, var3636=z2, var2725=java.lang.Object, var1265=$i2, var3119=org.apache.dubbo.common.utils.StringUtils, var2969=$z0, var3135=org.apache.dubbo.common.url.component.PathURLAddress, var2307=$r11, var2468=org.apache.dubbo.common.url.component.URLAddress, var728=org.apache.dubbo.common.url.component.URLParam, var1117=$r8}
; {org.apache.dubbo.common.URL=var62, r0=var462, r3=var1215, null_type=var3293, r1=var3890, r4=var1527, r6=var3529, i0=var3914, r5=var3053, java.util.Map=var2711, r7=var292, z2=var3636, java.lang.Object=var2725, $i2=var1265, org.apache.dubbo.common.utils.StringUtils=var3119, $z0=var2969, org.apache.dubbo.common.url.component.PathURLAddress=var3135, $r11=var2307, org.apache.dubbo.common.url.component.URLAddress=var2468, org.apache.dubbo.common.url.component.URLParam=var728, $r8=var1117}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.String;	i0 := @parameter4: int;	r5 := @parameter5: java.lang.String;	r7 := @parameter6: java.util.Map;	z2 := @parameter7: boolean;	specialinvoke r0.<java.lang.Object: void <init>()>();	$i2 = (int) -1;	r0.<org.apache.dubbo.common.URL: int hashCodeCache> = $i2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r11 = new org.apache.dubbo.common.url.component.PathURLAddress;	$r11 = new org.apache.dubbo.common.url.component.PathURLAddress;	specialinvoke $r11.<org.apache.dubbo.common.url.component.PathURLAddress: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,int)>(r3, r1, r4, r5, r6, i0);	r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> = $r11;	$r8 = staticinvoke <org.apache.dubbo.common.url.component.URLParam: org.apache.dubbo.common.url.component.URLParam parse(java.util.Map)>(r7);	r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLParam urlParam> = $r8;	r0.<org.apache.dubbo.common.URL: java.util.Map attributes> = null;	return
;block_num 2