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

(declare-sort var595 0)
(declare-sort var2885 0)
(declare-sort var3946 0)
(declare-sort var3971 0)
(declare-sort var2926 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun getPort/20614931 (var595) Int)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun urlAddress/1606454354 (var595) var3946)
(declare-fun var3971-init () var3971)
(declare-fun getProtocol/491749358 (var595) String)
(declare-fun getPath/898047937 (var595) String)
(declare-fun getParameters/-392598339 (var595) var2926)
(declare-fun <init>/-1145568936 (var3971 String String Int String var2926) void)
(declare-const null-var595 var595)
(declare-const null-String String)
(declare-const null-var3946 var3946)
(declare-const var3429 var595) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3429 null-var595)))
(declare-const var1842 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1842 null-String)))
(assert true)
(define-const var3921 Int (lastIndexOf/-1292097097 var1842 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
(assert true)
(define-const var942 Int (getPort/20614931 var3429)) ; Statement: i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>() 
 ; Statement: if i0 < 0 goto r11 = r0 
(assert (not (< var3921 0))) ; Negate: Cond: i0 < 0  
(assert (and true (and (>= 0 0) (>= (str.len var1842) var3921) (>= var3921 0))))
(define-const var3784 String (substring/-1240304868 var1842 0 var3921)) ; Statement: r11 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(define-const var1073 Int (+ var3921 1)) ; Statement: $i1 = i0 + 1 
(assert (and true (and (>= var1073 0) (>= (str.len var1842) var1073))))
(define-const var110 String (substring/850833817 var1842 var1073)) ; Statement: $r10 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1) 
(define-const var942!1 Int (Int_parseInt/1370970945 var110)) ; Statement: i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r10) 
 ; Statement: goto [?= $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>] 
(assert true) ; Non Conditional
(define-const var3534 var3946 (urlAddress/1606454354 var3429)) ; Statement: $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
 ; Statement: if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert (not (not (= var3534 null-var3946)))) ; Negate: Cond: $r2 != null  
(define-const var1876 var3971 var3971-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert true)
(define-const var2179 String (getProtocol/491749358 var3429)) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var662 String (getPath/898047937 var3429)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var1986 var2926 (getParameters/-392598339 var3429)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>() 
(assert true)
;(assert (<init>/-1145568936 var1876 var2179 var3784 var942!1 var662 var1986)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>($r9, r11, i2, $r8, $r7) 

(declare-const var1876!1 var3971)
(declare-const var2179!1 String)
(declare-const var3784!1 String)
(declare-const var942!2 Int)
(declare-const var662!1 String)
(declare-const var1986!1 var2926)
 ; Statement: return $r6 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), getPort/20614931=([org.apache.dubbo.common.URL], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), var3971-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), getParameters/-392598339=([org.apache.dubbo.common.URL], java.util.Map), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void)}
; {var595=org.apache.dubbo.common.URL, var3429=r1, var1842=r0, var2885=null_type, var3921=i0, var942=i2, var3784=r11, var1073=$i1, var110=$r10, var3946=org.apache.dubbo.common.url.component.URLAddress, var3534=$r2, var3971=org.apache.dubbo.common.url.component.ServiceConfigURL, var1876=$r6, var2179=$r9, var662=$r8, var2926=java.util.Map, var1986=$r7}
; {org.apache.dubbo.common.URL=var595, r1=var3429, r0=var1842, null_type=var2885, i0=var3921, i2=var942, r11=var3784, $i1=var1073, $r10=var110, org.apache.dubbo.common.url.component.URLAddress=var3946, $r2=var3534, org.apache.dubbo.common.url.component.ServiceConfigURL=var3971, $r6=var1876, $r9=var2179, $r8=var662, java.util.Map=var2926, $r7=var1986}
;seq <java.lang.String: int lastIndexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getPort()>();	if i0 < 0 goto r11 = r0;	r11 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$i1 = i0 + 1;	$r10 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>($i1);	i2 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r10);	goto [?= $r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>];	$r2 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	if $r2 != null goto $r3 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	$r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r9 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.Map getParameters()>();	specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>($r9, r11, i2, $r8, $r7);	return $r6
;block_num 4