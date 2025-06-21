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

(declare-sort var1091 0)
(declare-sort var2586 0)
(declare-sort var3908 0)
(declare-sort var1299 0)
(declare-sort var901 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun getPort/20614931 (var1091) Int)
(declare-fun urlAddress/1606454354 (var1091) var3908)
(declare-fun var1299-init () var1299)
(declare-fun getProtocol/491749358 (var1091) String)
(declare-fun getPath/898047937 (var1091) String)
(declare-fun getParameters/-392598339 (var1091) var901)
(declare-fun <init>/-1145568936 (var1299 String String Int String var901) void)
(declare-const null-var1091 var1091)
(declare-const null-String String)
(declare-const null-var3908 var3908)
(declare-const var3487 var1091) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3487 null-var1091)))
(declare-const var3402 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3402 null-String)))
(assert true)
(define-const var3444 Int (lastIndexOf/-1292097097 var3402 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(assert true)
(define-const var559 Int (getPort/20614931 var3487)) ; Statement: i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
 ; Statement: if i0 < 0 goto r11 = r0 
(assert (< var3444 0)) ; Cond: i0 < 0 
(define-const var2551 String var3402) ; Statement: r11 = r0 
(assert true) ; Non Conditional
(define-const var2283 var3908 (urlAddress/1606454354 var3487)) ; Statement: $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
 ; Statement: if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert (not (not (= var2283 null-var3908)))) ; Negate: Cond: $r2 != null  
(define-const var3121 var1299 var1299-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert true)
(define-const var1642 String (getProtocol/491749358 var3487)) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1833 String (getPath/898047937 var3487)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var573 var901 (getParameters/-392598339 var3487)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(assert true)
;(assert (<init>/-1145568936 var3121 var1642 var2551 var559 var1833 var573)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>($r9, r11, i2, $r8, $r7) 

(declare-const var3121!1 var1299)
(declare-const var1642!1 String)
(declare-const var2551!1 String)
(declare-const var559!1 Int)
(declare-const var1833!1 String)
(declare-const var573!1 var901)
 ; Statement: return $r6 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), getPort/20614931=([org.apache.dubbo.common.URL], int), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), var1299-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void)}
; {var1091=org.apache.dubbo.common.URL, var3487=r1, var3402=r0, var2586=null_type, var3444=i0, var559=i2, var2551=r11, var3908=org.apache.dubbo.common.url.component.URLAddress, var2283=$r2, var1299=org.apache.dubbo.common.url.component.ServiceConfigURL, var3121=$r6, var1642=$r9, var1833=$r8, var901=java.util.Map, var573=$r7}
; {org.apache.dubbo.common.URL=var1091, r1=var3487, r0=var3402, null_type=var2586, i0=var3444, i2=var559, r11=var2551, org.apache.dubbo.common.url.component.URLAddress=var3908, $r2=var2283, org.apache.dubbo.common.url.component.ServiceConfigURL=var1299, $r6=var3121, $r9=var1642, $r8=var1833, java.util.Map=var901, $r7=var573}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	if i0 < 0 goto r11 = r0;	r11 = r0;	$r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	$r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>($r9, r11, i2, $r8, $r7);	return $r6
;block_num 4