using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;

public class AsyncHelper
{
    delegate void DynamicInvokeShimProc(Delegate d, object[] args);

    static DynamicInvokeShimProc dynamicInvokeShim = new
        DynamicInvokeShimProc(DynamicInvokeShim);

    static AsyncCallback dynamicInvokeDone = new
        AsyncCallback(DynamicInvokeDone);

    public static void FireAndForget(Delegate d, params object[] args)
    {
        dynamicInvokeShim.BeginInvoke(d, args, dynamicInvokeDone, null);
    }

    static void DynamicInvokeShim(Delegate d, object[] args)
    {
        d.DynamicInvoke(args);
    }

    static void DynamicInvokeDone(IAsyncResult ar)
    {
        dynamicInvokeShim.EndInvoke(ar);
    }
}

/// <summary>
/// Descripción breve de EventsHelper
/// </summary>
public class EventsHelper
{
    public static void FireAsync(Delegate del, params object[] args)
    {
        if (del == null)
        {
            return;
        }
        Delegate[] delegates = del.GetInvocationList();
        AsyncFire asyncFire;
        foreach (Delegate sink in delegates)
        {
            asyncFire = new AsyncFire(InvokeDelegate);
            AsyncHelper.FireAndForget(asyncFire, sink, args);
        }
    }

    delegate void AsyncFire(Delegate del, object[] args);

    //[OneWay]
    static void InvokeDelegate(Delegate del, object[] args)
    {
        del.DynamicInvoke(args);
    }

    public static void Fire(Delegate del, params object[] args)
    {
        if (del == null)
        {
            return;
        }
        Delegate[] delegates = del.GetInvocationList();
        foreach (Delegate sink in delegates)
        {
            try
            {
                sink.DynamicInvoke(args);
            }
            catch { }
        }
    }
}
